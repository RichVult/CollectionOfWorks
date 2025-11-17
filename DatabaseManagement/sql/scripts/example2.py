import tkinter as tk
from tkinter import Text

# Create the main window
window = tk.Tk()
window.title("Example Application")

# Create and configure the text box
text_box = Text(window, height=5, width=40)
text_box.insert('1.0', "Adam Wittmann \nChristian Farrell")
text_box.pack(pady=10)

# Create and configure the Quit button
quit_button = tk.Button(window, text="Quit", command=window.destroy)
quit_button.pack(pady=10)

# Run the application
window.mainloop()