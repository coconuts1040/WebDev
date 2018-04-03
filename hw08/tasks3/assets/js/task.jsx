// Taken from Nat Tuck's lecture notes
import React from 'react';
import { Card, CardBody } from 'reactstrap';

export default function Task(params) {
    let task = params.task;
    return <Card>
        <CardBody>
            <div>
                <p><strong>Title:</strong> <b>{ task.title }</b></p>
                <p><strong>Assigned to:</strong> <b>{ task.user.name }</b></p>
                <p><strong>Description:</strong> <b>{ task.description }</b></p>
                <p><strong>Progress:</strong> <b>{ task.progress }</b></p>
                <p><strong>Completed:</strong> <b>{ task.completed }</b></p>
            </div>
        </CardBody>
    </Card>;
}
