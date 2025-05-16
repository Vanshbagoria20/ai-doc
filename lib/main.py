from flask import Flask, request, jsonify
import os
import json
from groq import Groq
from flask_cors import CORS

# Load API key from config
working_dir = os.path.dirname(os.path.abspath(__file__))
config_path = os.path.join(working_dir, "config.json")
with open(config_path, 'r') as config_file:
    config_data = json.load(config_file)

GROQ_API_KEY = config_data["GROQ_API_KEY"]
os.environ["GROQ_API_KEY"] = GROQ_API_KEY

client = Groq(api_key=GROQ_API_KEY)

# Initialize Flask app
app = Flask(__name__)
CORS(app)  # Enable CORS for Flutter

@app.route('/chatbot', methods=['POST'])
def chatbot():
    data = request.json
    user_message = data.get("message", "")

    messages = [
        {"role": "system", "content": "You are a helpful medical assistant."},
        {"role": "user", "content": user_message}
    ]

    response = client.chat.completions.create(
        model="llama-3.1-8b-instant",
        messages=messages
    )

    assistant_response = response.choices[0].message.content

    return jsonify({"response": assistant_response})

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000, debug=True)
