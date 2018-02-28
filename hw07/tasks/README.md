Rather than having two types of users (managers and non-managers), I gave
each user the option to manage other users. This makes sense in an
environment where teams are constantly changing. If the user wants to
view another user's tasks (manage them), they must go to the Users page
that displays all users and click the "Manage" button next to their name.
If they no longer need to keep track of them, they can click "Unmanage"
on the same button. Users can see the tasks of all the users they manage
on the Task Report page.

Users who wish to create a task may not assign it to a user they do not
manage. This means that if they do not manage themselves, they cannot
assign themselves a task.

Only the user to which a task is assigned may edit the task. This means
managers cannot edit a task of a user they manage. This design choice
was not made for any particular reason beyond discouraging
micromanagement.

When creating a new task, the user can input a single time block. This
time block will display as a string in the Show page. Those are all the
features I had time to implement.
