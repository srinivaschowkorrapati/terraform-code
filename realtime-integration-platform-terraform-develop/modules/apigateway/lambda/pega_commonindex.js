var aws = require("aws-sdk");
var client = new aws.SecretsManager({
    region: 'eu-west-1' // Your region
});
var secret, decodedBinarySecret;
var secretid=process.env.SECRET_ID;
//context.callbackWaitsForEmptyEventLoop = false;
exports.handler = (event, context, callback) => {
    client.getSecretValue({
        SecretId: secretid
    }, function(err, data) {
        if (err) {
            if (err.code === 'DecryptionFailureException')
                // Secrets Manager can't decrypt the protected secret text using the provided KMS key.
                // Deal with the exception here, and/or rethrow at your discretion.
                throw err;
            else if (err.code === 'InternalServiceErrorException')
                // An error occurred on the server side.
                // Deal with the exception here, and/or rethrow at your discretion.
                throw err;
            else if (err.code === 'InvalidParameterException')
                // You provided an invalid value for a parameter.
                // Deal with the exception here, and/or rethrow at your discretion.
                throw err;
            else if (err.code === 'InvalidRequestException')
                // You provided a parameter value that is not valid for the current state of the resource.
                // Deal with the exception here, and/or rethrow at your discretion.
                throw err;
            else if (err.code === 'ResourceNotFoundException')
                // We can't find the resource that you asked for.
                // Deal with the exception here, and/or rethrow at your discretion.
                throw err;
        } else {
            // Decrypts secret using the associated KMS CMK.
            // Depending on whether the secret is a string or binary, one of these fields will be populated.
            if ('SecretString' in data) {
                secret = data.SecretString;
            } else {
                let buff = new Buffer(data.SecretBinary, 'base64');
                decodedBinarySecret = buff.toString('ascii');
            }
        }
// Your code goes here.
       
        
        var authorizationHeader = event.headers.Authorization

        if (!authorizationHeader) return callback('Unauthorized')

        var encodedCreds = authorizationHeader.split(' ')[1]
        var plainCreds = new Buffer(encodedCreds, 'base64').toString().split(':')
        var username = plainCreds[0]
        var password = plainCreds[1]
        const jsonobj= JSON.parse(secret);
        var pegauser=jsonobj.pega_userName;
        var pegapassword=jsonobj.pega_password;
        
        if (!(username === pegauser && password === pegapassword)) return callback('Unauthorized')

        var authResponse = buildAllowAllPolicy(event, username)

        callback(null, authResponse)
	
    });
};


function buildAllowAllPolicy (event, principalId) {
  var apiOptions = {}
  var tmp = event.methodArn.split(':')
  var apiGatewayArnTmp = tmp[5].split('/')
  var awsAccountId = tmp[4]
  var awsRegion = tmp[3]
  var restApiId = apiGatewayArnTmp[0]
  var stage = apiGatewayArnTmp[1]
  var apiArn = 'arn:aws:execute-api:' + awsRegion + ':' + awsAccountId + ':' +
    restApiId + '/' + stage + '/*/*'
  const policy = {
    principalId: principalId,
    policyDocument: {
      Version: '2012-10-17',
      Statement: [
        {
          Action: 'execute-api:Invoke',
          Effect: 'Allow',
          Resource: [apiArn]
        }
      ]
    }
  }
  return policy
};