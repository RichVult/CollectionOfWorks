from flask import Blueprint, render_template, request, redirect, url_for, flash, session, jsonify
import MySQLdb.cursors
import re
import hashlib

views = Blueprint('views', __name__)
mysql = None  # Placeholder — will be set later

def init_mysql(mysql_instance):
    global mysql
    mysql = mysql_instance


@views.route('/')
def index():
    return render_template('index.html')

@views.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']
        print(f"[DEBUG] Login attempt: email={email}")
        cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        
        # First check if user is an admin
        cur.execute("SELECT * FROM admin WHERE email=%s AND admin_password=SHA2(%s, 256)", (email, password))
        admin = cur.fetchone()
        
        if admin:
            session['user_id'] = admin['admin_id']
            session['email'] = admin['email']
            session['user_type'] = 'admin'
            session['profile_pic'] = url_for('static', filename='marist.jpeg')  # Placeholder
            flash('Login successful!', 'success')
            cur.close()
            return redirect(url_for('views.admin'))
        
        # If not admin, check regular users
        cur.execute("SELECT * FROM users WHERE email=%s AND user_password=SHA2(%s, 256)", (email, password))
        user = cur.fetchone()
        print(f"[DEBUG] User found: {user}")
        
        if user:
            session['user_id'] = user['user_id']
            session['email'] = user['email']
            session['user_type'] = 'user'
            session['profile_pic'] = url_for('static', filename='marist.jpeg')  # Placeholder
            flash('Login successful!', 'success')
            cur.close()
            return redirect(url_for('views.user'))
        else:
            cur.close()
            flash('Invalid credentials', 'danger')
    return render_template('login.html')

@views.route('/logout', methods=['GET', 'POST'])
def logout():
    session.clear()
    flash('You have been logged out.', 'info')
    return redirect(url_for('views.login'))

@views.route('/signup', methods=['GET', 'POST'])
def signup():
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']
        confirm_password = request.form.get('confirm_password')
        phone = request.form['phone']
        gender = request.form['gender']
        fName = request.form['fName']
        lName = request.form['lName']
        print(f"[DEBUG] Signup attempt: email={email}, phone={phone}, gender={gender}, fName={fName}, lName={lName}")
        errors = []
        if password != confirm_password:
            errors.append("Passwords do not match.")
        if not re.match(r"[^@]+@[^@]+\.[^@]+", email) or len(email) > 320:
            errors.append("Invalid email format or too long (max 320 chars).")
        if not (1 <= len(password) <= 30):
            errors.append("Password must be 1-30 characters.")
        if not (1 <= len(phone) <= 20):
            errors.append("Phone number must be 1-20 characters.")
        if gender not in ['Male', 'Female', 'Other']:
            errors.append("Gender must be Male, Female, or Other.")
        if not fName or not lName:
            errors.append("First and last name are required.")

        if errors:
            print(f"[DEBUG] Signup validation errors: {errors}")
            for error in errors:
                flash(error, 'danger')
            return render_template('signup.html')

        cur = mysql.connection.cursor()
        try:
            cur.execute("INSERT INTO users (fName, lName, user_password, phone_number, email, gender) VALUES (%s, %s, %s, %s, %s, %s)",
                        (fName, lName, password, phone, email, gender))
            mysql.connection.commit()
            flash('Signup successful! Please log in.', 'success')
            print("[DEBUG] Signup successful and committed to DB.")
            return redirect(url_for('views.login'))
        except MySQLdb.IntegrityError as e:
            print(f"[DEBUG] Signup DB error: {e}")
            flash('Email already exists.', 'danger')
        except Exception as e:
            print(f"[DEBUG] Unexpected signup error: {e}")
            flash('An unexpected error occurred during signup.', 'danger')
        finally:
            cur.close()
    return render_template('signup.html')

@views.route('/admin')
def admin():
    if 'user_id' not in session or session.get('user_type') != 'admin':
        return redirect(url_for('views.login'))
    user_info = {
        'email': session.get('email'),
        'profile_pic': session.get('profile_pic'),
        'name': session.get('email').split('@')[0].replace('.', ' ').title()  # Placeholder for name
    }
    return render_template('admin.html', user=user_info)

@views.route('/user')
def user():
    if 'user_id' not in session or session.get('user_type') != 'user':
        return redirect(url_for('views.login'))
    cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute("SELECT fName, lName, email FROM users WHERE user_id=%s", (session['user_id'],))
    user_data = cur.fetchone()
    cur.close()
    user_info = {
        'email': session.get('email'),
        'profile_pic': session.get('profile_pic'),
        'name': f"{user_data['fName']} {user_data['lName']}" if user_data else session.get('email').split('@')[0].replace('.', ' ').title()
    }
    return render_template('user.html', user=user_info)

@views.route('/contact/<int:contact_id>')
def contact(contact_id):
    return render_template('contact.html', contact_id=contact_id)

@views.route('/new_contact')
def new_contact():
    return render_template('new_contact.html')

@views.route('/edit_contact/<int:contact_id>')
def edit_contact(contact_id):
    return render_template('edit_contact.html', contact_id=contact_id)

@views.route('/message')
def message():
    return render_template('message.html')

@views.route('/profile', methods=['GET', 'POST'])
def profile():
    if 'user_id' not in session or session.get('user_type') != 'user':
        return redirect(url_for('views.login'))
    cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    if request.method == 'POST':
        # Get form fields
        email = request.form.get('email')
        password = request.form.get('password')
        phone_number = request.form.get('phone_number')
        home_phone_number = request.form.get('home_phone_number')
        gender = request.form.get('gender')
        fax_number = request.form.get('fax_number')
        birth_date = request.form.get('birth_date')
        partner_id = request.form.get('partner_id') or None
        company_id = request.form.get('company_id') or None
        school_id = request.form.get('school_id') or None
        print(f"[DEBUG] POST /profile - Form data: email={email}, phone={phone_number}, home_phone={home_phone_number}, gender={gender}, fax={fax_number}, birth_date={birth_date}, partner_id={partner_id}, company_id={company_id}, school_id={school_id}")
        # Look up employer_id for selected company_id
        employer_id = None
        if company_id:
            cur.execute("SELECT employer_id FROM employer WHERE company_id = %s LIMIT 1", (company_id,))
            employer = cur.fetchone()
            if employer:
                employer_id = employer['employer_id']
        # Update user
        try:
            update_fields = []
            values = []
            if email:
                update_fields.append("email=%s")
                values.append(email)
            if phone_number:
                update_fields.append("phone_number=%s")
                values.append(phone_number)
            if home_phone_number:
                update_fields.append("home_phone_number=%s")
                values.append(home_phone_number)
            if gender:
                update_fields.append("gender=%s")
                values.append(gender)
            if fax_number:
                update_fields.append("fax_number=%s")
                values.append(fax_number)
            if birth_date:
                update_fields.append("birth_date=%s")
                values.append(birth_date)
            if partner_id:
                update_fields.append("partner_id=%s")
                values.append(partner_id)
            if employer_id:
                update_fields.append("employer_id=%s")
                values.append(employer_id)
            if school_id:
                update_fields.append("school_id=%s")
                values.append(school_id)
            if update_fields:
                set_clause = ", ".join(update_fields)
                values.append(session['user_id'])
                cur.execute(f"UPDATE users SET {set_clause} WHERE user_id=%s", values)
                mysql.connection.commit()
                print(f"[DEBUG] POST /profile - SQL update executed for user_id={session['user_id']}")
            # Handle password update if provided
            if password:
                cur.execute("UPDATE users SET user_password=SHA2(%s, 256) WHERE user_id=%s", (password, session['user_id']))
                mysql.connection.commit()
            flash('Profile updated successfully!', 'success')
            return redirect(url_for('views.user'))
        except Exception as e:
            print(f"[DEBUG] POST /profile - Error during update: {e}")
            flash('An error occurred while updating your profile. Please try again.', 'danger')
            return redirect(url_for('views.profile'))
    # GET logic (unchanged)
    cur.execute("SELECT * FROM users WHERE user_id=%s", (session['user_id'],))
    user = cur.fetchone() or {}
    # Get only the current user's partner
    partner = None
    if user.get('partner_id'):
        cur.execute("SELECT partner_id, partner_name FROM partner WHERE partner_id=%s", (user['partner_id'],))
        partner = cur.fetchone()
    partners = [partner] if partner else []
    # Get all companies
    cur.execute("SELECT company_id, company_name FROM company")
    companies = cur.fetchall()
    # Get all schools
    cur.execute("SELECT school_id, school_name FROM school")
    schools = cur.fetchall()
    # Look up company_id for current employer_id
    if user.get('employer_id'):
        cur.execute("SELECT company_id FROM employer WHERE employer_id=%s", (user['employer_id'],))
        employer = cur.fetchone()
        if employer:
            user['company_id'] = employer['company_id']
    # Look up school_name for current school_id
    if user.get('school_id'):
        cur.execute("SELECT school_name FROM school WHERE school_id=%s", (user['school_id'],))
        school = cur.fetchone()
        if school:
            user['school_name'] = school['school_name']
    cur.close()
    return render_template('profile.html', user=user, partners=partners, companies=companies, schools=schools)

@views.route('/add_partner', methods=['POST'])
def add_partner():
    if 'user_id' not in session or session.get('user_type') != 'user':
        return jsonify({'error': 'Unauthorized'}), 401

    partner_name = request.form.get('partner_name')
    birth_year = request.form.get('birth_year')
    birth_month = request.form.get('birth_month')
    gender = request.form.get('gender')

    if not partner_name or not birth_year or not birth_month or not gender:
        return jsonify({'error': 'Missing fields'}), 400

    cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute(
        "INSERT INTO partner (partner_name, birth_year, birth_month, gender) VALUES (%s, %s, %s, %s)",
        (partner_name, birth_year, birth_month, gender)
    )
    mysql.connection.commit()
    partner_id = cur.lastrowid

    # Update current user's partner_id
    cur.execute("UPDATE users SET partner_id=%s WHERE user_id=%s", (partner_id, session['user_id']))
    mysql.connection.commit()

    cur.close()
    return jsonify({'partner_id': partner_id, 'partner_name': partner_name})

@views.route('/contacts', methods=['GET', 'POST'])
def contacts():
    if 'user_id' not in session or session.get('user_type') != 'user':
        return redirect(url_for('views.login'))
    cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    # Fetch contacts for the current user
    cur.execute('''
        SELECT u.user_id, u.fName, u.lName, u.email
        FROM contacts c
        JOIN users u ON c.contact_user_id = u.user_id
        WHERE c.owner_user_id = %s
    ''', (session['user_id'],))
    contacts = cur.fetchall()
    # Fetch all users for add contact (exclude self and already-added contacts)
    cur.execute('''
        SELECT user_id, fName, lName, email FROM users
        WHERE user_id != %s AND user_id NOT IN (
            SELECT contact_user_id FROM contacts WHERE owner_user_id = %s
        )
    ''', (session['user_id'], session['user_id']))
    possible_contacts = cur.fetchall()
    cur.close()
    return render_template('contacts.html', contacts=contacts, possible_contacts=possible_contacts)

@views.route('/add_contact', methods=['POST'])
def add_contact():
    if 'user_id' not in session or session.get('user_type') != 'user':
        return jsonify({'error': 'Unauthorized'}), 401
    contact_user_id = request.form.get('contact_user_id')
    if not contact_user_id:
        return jsonify({'error': 'Missing contact_user_id'}), 400
    cur = mysql.connection.cursor()
    try:
        # Prevent duplicates
        cur.execute('''SELECT 1 FROM contacts WHERE owner_user_id=%s AND contact_user_id=%s''', (session['user_id'], contact_user_id))
        if cur.fetchone():
            return jsonify({'error': 'Contact already exists'}), 400
        cur.execute('''INSERT INTO contacts (owner_user_id, contact_user_id) VALUES (%s, %s)''', (session['user_id'], contact_user_id))
        mysql.connection.commit()
        return jsonify({'success': True, 'redirect': url_for('views.contacts')}), 200
    except Exception as e:
        print(f"[DEBUG] Error adding contact: {e}")
        return jsonify({'error': 'Failed to add contact'}), 400
    finally:
        cur.close()

@views.route('/remove_contact', methods=['POST'])
def remove_contact():
    if 'user_id' not in session or session.get('user_type') != 'user':
        return jsonify({'error': 'Unauthorized'}), 401
    contact_user_id = request.form.get('contact_user_id')
    if not contact_user_id:
        return jsonify({'error': 'Missing contact_user_id'}), 400
    cur = mysql.connection.cursor()
    try:
        cur.execute('''DELETE FROM contacts WHERE owner_user_id=%s AND contact_user_id=%s''', (session['user_id'], contact_user_id))
        mysql.connection.commit()
        return jsonify({'success': True}), 200
    except Exception as e:
        print(f"[DEBUG] Error removing contact: {e}")
        return jsonify({'error': 'Failed to remove contact'}), 400
    finally:
        cur.close()

@views.route('/messages')
def messages():
    if 'user_id' not in session or session.get('user_type') != 'user':
        return redirect(url_for('views.login'))

    cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)

    # Get all users we've messaged or received messages from
    cur.execute('''
        SELECT DISTINCT u.user_id, u.fName, u.lName, u.email
        FROM users u
        WHERE u.user_id != %s AND (
            u.user_id IN (SELECT user_id_sent FROM message WHERE user_id_recieve = %s)
            OR u.user_id IN (SELECT user_id_recieve FROM message WHERE user_id_sent = %s)
        )
    ''', (session['user_id'], session['user_id'], session['user_id']))
    messaged_users = cur.fetchall()

    # Get only contacts for new chat (exclude self and those already messaged)
    cur.execute('''
        SELECT u.user_id, u.fName, u.lName, u.email
        FROM contacts c
        JOIN users u ON c.contact_user_id = u.user_id
        WHERE c.owner_user_id = %s
          AND u.user_id NOT IN (
              SELECT DISTINCT u2.user_id
              FROM users u2
              WHERE u2.user_id != %s AND (
                  u2.user_id IN (SELECT user_id_sent FROM message WHERE user_id_recieve = %s)
                  OR u2.user_id IN (SELECT user_id_recieve FROM message WHERE user_id_sent = %s)
              )
          )
    ''', (session['user_id'], session['user_id'], session['user_id'], session['user_id']))
    possible_users = cur.fetchall()

    selected_user_id = request.args.get('user_id')
    messages_history = []
    selected_user = None
    is_contact = False  # Default to false

    if selected_user_id:
        cur.execute('''SELECT user_id, fName, lName, email FROM users WHERE user_id=%s''', (selected_user_id,))
        selected_user = cur.fetchone()

        if selected_user:
            # Check if the selected user is already a contact
            cur.execute('''SELECT 1 FROM contacts WHERE owner_user_id=%s AND contact_user_id=%s''', (session['user_id'], selected_user_id))
            is_contact = cur.fetchone() is not None

            # Get message history between current user and selected user
            cur.execute('''
                SELECT m.*, u.fName, u.lName
                FROM message m
                JOIN users u ON m.user_id_sent = u.user_id
                WHERE (m.user_id_sent = %s AND m.user_id_recieve = %s)
                   OR (m.user_id_sent = %s AND m.user_id_recieve = %s)
                ORDER BY m.message_date ASC, m.message_id ASC
            ''', (session['user_id'], selected_user_id, selected_user_id, session['user_id']))
            messages_history = cur.fetchall()

    cur.close()
    return render_template('messages.html', messaged_users=messaged_users, selected_user=selected_user, messages_history=messages_history, possible_users=possible_users, is_contact=is_contact)

@views.route('/send_message', methods=['POST'])
def send_message():
    if 'user_id' not in session or session.get('user_type') != 'user':
        return redirect(url_for('views.login'))
    recipient_id = request.form.get('recipient_id')
    message_content = request.form.get('message_content')
    if not recipient_id or not message_content:
        return redirect(url_for('views.messages'))
    cur = mysql.connection.cursor()
    try:
        # Insert message with content
        cur.execute('''INSERT INTO message (message_type, message_date, user_id_sent, user_id_recieve, message_content) VALUES (%s, CURDATE(), %s, %s, %s)''',
                    ('TEXT', session['user_id'], recipient_id, message_content))
        mysql.connection.commit()
    except Exception as e:
        print(f"[DEBUG] Error sending message: {e}")
    finally:
        cur.close()
    return redirect(url_for('views.messages', user_id=recipient_id))