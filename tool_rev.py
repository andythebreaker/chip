import tkinter as tk

def reverse_string():
    input_text = entry.get()
    reversed_text = ', '.join(reversed(input_text.split(',')))
    result_label.config(text=reversed_text)

# Create the main window
window = tk.Tk()
window.title("String Reversal")
window.geometry("300x200")

# Create the input label and entry widget
input_label = tk.Label(window, text="Enter a string (separated by commas):")
input_label.pack()
entry = tk.Entry(window)
entry.pack()

# Create the button to trigger the reversal
button = tk.Button(window, text="Reverse", command=reverse_string)
button.pack()

# Create the label to display the result
result_label = tk.Label(window, text="")
result_label.pack()

# Start the GUI event loop
window.mainloop()
