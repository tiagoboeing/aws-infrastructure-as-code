const axios = require('axios')

async function userInfo(event) {
  console.log('Handling userInfo...')

  const response = await axios.get('https://api.github.com/user', {
    headers: {
      Authorization: 'token ' + event.headers.authorization.split('Bearer ')[1],
      Accept: 'application/json'
    },
    maxRedirects: 0
  })

  return {
    statusCode: 200,
    body: JSON.stringify({
      ...response.data,
      sub: response.data.id
    })
  }
}

async function accessToken(event) {
  console.log('Handling accessToken...')

  const response = await axios.post(
    'https://github.com/login/oauth/access_token',
    event.body,
    {
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
        Accept: 'application/json'
      },
      maxRedirects: 0
    }
  )

  return {
    statusCode: 200,
    body: JSON.stringify(response.data)
  }
}

exports.handler = async (event) => {
  try {
    const {
      requestContext: {
        http: { method, path }
      }
    } = event

    console.log('requestContext', requestContext)

    if (method === 'POST' && path === '/oauth/github/access-token')
      return await accessToken(event)

    if (method === 'GET' && path === '/oauth/github/user-info')
      return await userInfo(event)

    return {
      statusCode: 404,
      body: 'Not Found'
    }
  } catch (error) {
    return {
      statusCode: error?.response?.status || 500,
      body: JSON.stringify(error?.response?.data || {})
    }
  }
}
