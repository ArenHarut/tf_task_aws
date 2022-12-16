exports.handler = async (event) => {
    const params = event.queryStringParameters;
    console.log("params", params);
    const bodyResponse = {
        temperature: 29,
        date: params.date,
        city: params.city
    }
    const response = {
        statusCode: 200,
        body: JSON.stringify(bodyResponse),
    };
    return response;
};