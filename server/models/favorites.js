const mongoose = require("mongoose");


const favoritesschema  = mongoose.Schema({
  image:{
    type:String,
    required:true,

  },
  name: {
    type: String,
    required: true,
  },
 
  totalPrice: {
    type: Number,
    required: true,
  },
  
  userId: {
    required: true,
    type: String,
  },
  
  
});

const Favorites = mongoose.model("Favorites", favoritesschema);
module.exports = Favorites;
