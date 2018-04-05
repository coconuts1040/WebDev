// Taken from Nat Tuck's lecture notes
import { createStore, combineReducers } from 'redux';
import deepFreeze from 'deep-freeze';

function tasks(state = [], action) {
    switch (action.type) {
        case 'TASKS_LIST':
            return [...action.tasks];
        case 'CREATE_TASK':
            return [action.task, ...state];
        default:
            return state;
    }
}

function users(state = [], action) {
    switch (action.type) {
        case 'USERS_LIST':
            return [...action.users];
        case 'CREATE_USER':
            return [action.user, ...state];
        default:
            return state;
    }
}

let empty_form = {
    user_id: "",
    title: "",
    description: "",
    progress: "",
    completed: false,
    token: "",
};

function form(state = empty_form, action) {
    switch (action.type) {
        case 'UPDATE_FORM':
            return Object.assign({}, state, action.data);
        case 'SET_TOKEN':
            return Object.assign({}, state, action.token);
        default:
            return state;
    }
}

let empty_user = {
    name: "",
    email: "",
    password: "",
};

function user_form(state = empty_user, action) {
    switch(action.type) {
        case 'UPDATE_USER_FORM':
            return Object.assign({}, state, action.data);
        default:
            return state;
    }
}

function token(state = null, action) {
    switch (action.type) {
        case 'SET_TOKEN':
            return action.token;
        default:
            return state;
    }
}

let empty_login = {
    email: "",
    pass: "",
};

function login(state = empty_login, action) {
    switch (action.type) {
        case 'UPDATE_LOGIN_FORM':
            return Object.assign({}, state, action.data);
        default:
            return state;
    }
}

function root_reducer(state0, action) {
    console.log("root_reducer", action);
    let reducer = combineReducers({tasks, users, form, token, login, user_form});

    let state1 = reducer(state0, action);
    console.log("state1", state1);
    return deepFreeze(state1);
};

let store = createStore(root_reducer);
export default store;
