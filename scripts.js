function LoginValidaton(){
    let username = document.loginForm.Username.value;
    let password = document.loginForm.Password.value;

    if(username === "" || password === ""){
        document.getElementById("alert").innerHTML = "Userame or password can't be empty.";
        return false;
    }
    else
        return true;
}

function PostValidaton(){
    let post = document.blogForm.blogInput.value;

    if(post === "")
        return false;
    else
        return true;
}

function SignUpValidaton(){
    let firstname = document.signUpForm.Firstname.value;
    let lastname = document.signUpForm.Lastname.value;
    let username = document.signUpForm.Username.value;
    let password = document.signUpForm.Password.value;
    let password_re = document.signUpForm.Password_Re.value;

    if(firstname === "" || lastname === "" || username === "" || password === "" || password_re === ""){
        document.getElementById("alert").innerHTML = "All fields must be filled.";
        return false;
    }
    else if(password !== password_re){
        document.getElementById("alert").innerHTML = "Passwords don't match.";
        return false;
    }
    else
        return true;
}

function popupConfirm(message){
    if(confirm(message))
        return true;
    else
        return false;
}

function EditCheck(id){
    const object = document.getElementById("p_" + id);

    if(object.tagName === 'P'){
        if(confirm("Do you want to edit this post?")){
            const textArea = document.createElement("textarea");

            for (const attribute of object.attributes)
                textArea.setAttribute(attribute.name, attribute.value);

            textArea.value = object.innerHTML;
            object.replaceWith(textArea);
        }
    }
    else if(object.tagName === 'TEXTAREA'){
        if(confirm("Save these changes?")){
            const editForm = document.getElementById("editForm_" + id);
            editForm.editPost_desc.value = object.value;

            return true;
        }
        else{
            const paragraph = document.createElement("p");

            for (const attribute of object.attributes)
                paragraph.setAttribute(attribute.name, attribute.value);

            paragraph.innerHTML = object.value;
            object.replaceWith(paragraph);
        }
    }

    return false;
}