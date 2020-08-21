const dev = true;

const serverUrl = dev ? 'http://localhost:8080' : '';

const TOKEN_TO_ID = '$serverUrl/tokenToID';

const SIGNIN = '$serverUrl/api/account/signin';
const SIGNUP = '$serverUrl/api/account/signup';
const GET_USER_INFO = '$serverUrl/getUserInfo';
const GET_USER_FITNESS = '$serverUrl/getUserActivityData';
