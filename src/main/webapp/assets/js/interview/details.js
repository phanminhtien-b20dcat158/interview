var modalHtml = `
    <style>
        .modal-content {
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .modal-header {
            background-color: #f8f9fa;
            border-bottom: 1px solid #dee2e6;
        }

        .modal-title {
            font-size: 1.25rem;
            font-weight: 500;
        }

        .modal-body {
            font-size: 1rem;
            color: #495057;
        }

        .modal-footer {
            border-top: 1px solid #dee2e6;
        }

        .btn-danger {
            background-color: #dc3545;
            border-color: #dc3545;
        }

        .btn-secondary {
            background-color: #6c757d;
            border-color: #6c757d;
        }
    </style>
    <div class="modal fade" id="confirmModal" tabindex="-1" role="dialog" aria-labelledby="confirmModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="confirmModalLabel">Confirm Send Reminder</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to send reminder this interview?</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-danger" id="confirmInterviewReminderBtn">Confirm</button>
                </div>
            </div>
        </div>
    </div>
    `;

function insertModal() {
    var modalContainer = document.createElement('div');
    modalContainer.innerHTML = modalHtml;
    document.body.appendChild(modalContainer);
}

function confirmInterviewReminder(interviewId) {
    // Insert modal HTML if not already in the DOM
    if (!document.getElementById('confirmModal')) {
        insertModal();
    }

    // Set interviewId on the confirm button
    document.getElementById('confirmInterviewReminderBtn').onclick = function() {
        window.location.href = '/interview/reminder?interviewId=' + interviewId;
    };

    // Show the modal
    $('#confirmModal').modal('show');
}