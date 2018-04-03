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
        default:
            return state;
    }
}

let empty_form = {
    user_id: "",
    body: "",
};

function form(state = empty_form, action) {
    switch (action.type) {
        case 'UPDATE_FORM':
            return Object.assign({}, state, action.data);
        default:
            return state;
    }
}

function root_reducer(state0, action) {
    console.log("root_reducer", action);
    let reducer = combineReducers({tasks, users, form});

    let state1 = reducer(state0, action);
    console.log("state1", state1);
    return deepFreeze(state1);
};

let store = createStore(root_reducer);
export default store;
