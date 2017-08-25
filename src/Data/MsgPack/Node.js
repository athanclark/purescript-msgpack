"use strict";

var msgpack = require('msgpack-js');


exports.encode = function encode (x) {
  return msgpack.encode(x);
};

exports.decodeImpl = function decodeImpl (left,right,x) {
  var result;
  try {
    result = right(msgpack.decode(x));
  } catch (e) {
    result = left(e);
  }
  return result;
};
