$("#edit_user").validate({
debug: false,
rules: {
"user[username]": {required: true, lettersonly: true },
"user[title]": {required: true , minlength: 2},
"user[password]": {required: true, minlength: 8},
"user[password_confirmation]": {required: true, equalTo: "#user_password"},
"user[current_password]": {required: true}
},
  messages: {
    "user[username]": {required: "Please enter your name", lettersonly: "* Please enter only alphabetical letters"},
    "user[title]": "(must be at least 2 characters long)",
    "user[password]": {required: "* password is required", minlength: "must be at least 8 characters"},
    "user[password_confirmation]": {required: "* password is required", equalTo: "Please enter the same password as above"},
    "user[current_password]": "* password is required"
  }
});

$("#new_user").validate({
  debug: false,
rules: {
"user[email]": {required: true, email: true},
"user[password]": {required: true}
},
  messages: {
    "user[email]": {
        required: "* Please enter email",
        email: "* Please enter a valid email address"},
    "user[password]": "* password is required"
  }
});