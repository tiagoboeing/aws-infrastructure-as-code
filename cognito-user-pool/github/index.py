import requests
from flask import request, jsonify
from main import app


@app.route('/oauth/github/access-token', methods=['POST'])
def get_access_token():
    github_request = requests.post(
        url='https://github.com/login/oauth/access_token',
        headers={
            'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
            'Accept': 'application/json'
        },
        data=request.form.to_dict(),
        allow_redirects=False
    )
    response = github_request.json()

    return jsonify(response)


@app.route('/oauth/github/user-info', methods=['GET'])
def get_user_info():
    github_request = requests.get(
        url='https://api.github.com/user',
        headers={
            'Authorization': 'token ' + request.headers.get('Authorization').split('Bearer ')[1],
            'Accept': 'application/json'
        },
        allow_redirects=False
    )
    response = github_request.json()

    return jsonify({
        **response,
        'sub': response['id']
    })