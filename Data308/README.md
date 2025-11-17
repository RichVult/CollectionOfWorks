# Marist CMS

A simple Contact Management System built with Flask and MySQL.

## Prerequisites

*   **Python 3:** Ensure you have Python 3 installed. You can download it from [python.org](https://www.python.org/).
*   **MySQL:** A running MySQL server instance is required. You can download it from [mysql.com](https://www.mysql.com/).
*   **pip:** Python's package installer, usually included with Python 3.

## Setup Instructions

1.  **Clone the Repository (if necessary):**
    ```bash
    git clone <repository_url>
    cd MaristCMS
    ```

2.  **Create and Activate a Virtual Environment:**
    Using a virtual environment is highly recommended to manage dependencies.

    *   **macOS/Linux:**
        ```bash
        python3 -m venv venv
        source venv/bin/activate
        ```
    *   **Windows:**
        ```bash
        python -m venv venv
        .\venv\Scripts\activate
        ```

3.  **Install Dependencies:**
    Install the required Python packages from `requirements.txt`.
    ```bash
    pip install -r requirements.txt
    ```

4.  **Database Setup:**
    *   Log in to your MySQL server:
        ```bash
        mysql -u <your_mysql_username> -p
        ```
    *   Run the initialization script to create the database, tables, and initial data. Make sure you are in the project's root directory.
        ```bash
        mysql -u <your_mysql_username> -p < sql/scripts/Init_ui_environment.sql
        ```
        *(You might need to enter your MySQL password again.)*

5.  **Set Environment Variables:**
    This application requires several environment variables to connect to the database and run securely. You can set these in your terminal session, or preferably, use a `.env` file (if you have `python-dotenv` installed and configured in `app.py`).

    *   `MYSQL_HOST`: The hostname of your MySQL server (e.g., `localhost` or `127.0.0.1`).
    *   `MYSQL_USER`: Your MySQL username.
    *   `MYSQL_PASSWORD`: Your MySQL password.
    *   `MYSQL_DB`: The name of the database (should be `MaristCMS` as created by the script).
    *   `FLASK_SECRET_KEY`: A random, secret string for session security. Generate one using `python -c 'import os; print(os.urandom(24).hex())'`.

    *   **Example (macOS/Linux):**
        ```bash
        export MYSQL_HOST='localhost'
        export MYSQL_USER='your_mysql_username'
        export MYSQL_PASSWORD='your_mysql_password'
        export MYSQL_DB='MaristCMS'
        export FLASK_SECRET_KEY='your_generated_secret_key'
        ```
    *   **Example (Windows - Command Prompt):**
        ```cmd
        set MYSQL_HOST=localhost
        set MYSQL_USER=your_mysql_username
        set MYSQL_PASSWORD=your_mysql_password
        set MYSQL_DB=MaristCMS
        set FLASK_SECRET_KEY=your_generated_secret_key
        ```
    *   **Example (Windows - PowerShell):**
        ```powershell
        $env:MYSQL_HOST = "localhost"
        $env:MYSQL_USER = "your_mysql_username"
        $env:MYSQL_PASSWORD = "your_mysql_password"
        $env:MYSQL_DB = "MaristCMS"
        $env:FLASK_SECRET_KEY = "your_generated_secret_key"
        ```

6.  **Run the Application:**
    From the project's **root directory**, run the Flask application:
    ```bash
    python UI/app.py
    ```

7.  **Access the Application:**
    Open your web browser and navigate to `http://127.0.0.1:5000` (or the address provided in the terminal output).

## Deactivating the Virtual Environment

When you are finished working on the project, you can deactivate the virtual environment:
```bash
deactivate
```