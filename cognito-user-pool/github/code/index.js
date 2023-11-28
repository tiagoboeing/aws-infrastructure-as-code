/**
 * Based on this article: https://blog.ducthinh.net/github-openid-idp-aws-cognito/
 */
const axios = require('axios')

async function userInfo(event) {
  console.log('Handling userInfo...')

  if (!event.headers?.authorization)
    throw new Error('Header Authorization must be passed!')

  const response = await axios.get('https://api.github.com/user', {
    headers: {
      Authorization: 'token ' + event.headers?.authorization?.split('Bearer ')[1],
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
    console.log('Handling event...')
    console.log(event)

    const {
      httpMethod,
      pathParameters: { proxy: path }
    } = event

    if (httpMethod === 'POST' && path === 'oauth/access_token')
      return await accessToken(event)

    if (httpMethod === 'GET' && path === 'oauth/user') return await userInfo(event)

    return {
      statusCode: 404,
      body: JSON.stringify({ message: 'Route not found' })
    }
  } catch (error) {
    console.error(error)

    return {
      statusCode: error?.response?.status || 500,
      body: JSON.stringify(error?.response?.data || {})
    }
  }
}
