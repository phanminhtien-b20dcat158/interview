function initializeDropdown(dropdownId, menuId, selectedId, hiddenFieldId, searchId) {
    var dropdown = document.getElementById(dropdownId);
    var menu = document.getElementById(menuId);
    var selectedElement = document.getElementById(selectedId);
    var hiddenField = document.getElementById(hiddenFieldId);
    var searchInput = document.getElementById(searchId);

    dropdown.addEventListener('click', function () {
        menu.classList.toggle('show');
    });

    searchInput.addEventListener('keyup', function () {
        var filter = this.value.toLowerCase();
        var items = menu.getElementsByClassName('dropdown-item');
        Array.prototype.forEach.call(items, function (item) {
            if (item.innerText.toLowerCase().includes(filter)) {
                item.style.display = '';
            } else {
                item.style.display = 'none';
            }
        });
    });

    document.querySelectorAll('#' + menuId + ' .dropdown-item').forEach(function (item) {
        item.addEventListener('click', function (event) {
            event.preventDefault();
            var value = this.getAttribute('data-value');
            var text = this.innerText;

            var existingItems = selectedElement.getElementsByClassName('selected-item');
            for (var i = 0; i < existingItems.length; i++) {
                if (existingItems[i].getAttribute('data-value') === value) {
                    return;
                }
            }

            var element = document.createElement('span');
            element.setAttribute('class', 'selected-item badge badge-primary mr-2');
            element.setAttribute('data-value', value);
            element.innerHTML = text + ' <i class="fas fa-times remove-item"></i>';

            element.querySelector('.remove-item').addEventListener('click', function () {
                this.parentNode.remove();
                updateHiddenField();
            });

            selectedElement.appendChild(element);
            updateHiddenField();
            menu.classList.remove('show');
        });
    });

    selectedElement.addEventListener('click', function (event) {
        if (event.target.classList.contains('remove-item')) {
            event.target.parentNode.remove();
            updateHiddenField();
        }
    });

    function updateHiddenField() {
        var values = [];
        selectedElement.querySelectorAll('.selected-item').forEach(function (item) {
            values.push(item.getAttribute('data-value'));
        });
        hiddenField.value = values.join(',');
    }

    // Load initial values from hidden field
    var initialValue = hiddenField.value;
    if (initialValue) {
        initialValue.split(',').forEach(function (value) {
            var item = document.querySelector('#' + menuId + ' .dropdown-item[data-value="' + value + '"]');
            if (item) {
                var text = item.innerText;
                var element = document.createElement('span');
                element.setAttribute('class', 'selected-item badge badge-primary mr-2');
                element.setAttribute('data-value', value);
                element.innerHTML = text + ' <i class="fas fa-times remove-item"></i>';

                element.querySelector('.remove-item').addEventListener('click', function () {
                    this.parentNode.remove();
                    updateHiddenField();
                });

                selectedElement.appendChild(element);
            }
        });
        updateHiddenField();
    }
}

document.addEventListener('DOMContentLoaded', function () {
    initializeDropdown('skillsDropdown', 'skillsMenu', 'selectedSkills', 'skills', 'skillsSearch');
    initializeDropdown('benefitsDropdown', 'benefitsMenu', 'selectedBenefits', 'benefits', 'benefitsSearch');
    initializeDropdown('levelsDropdown', 'levelsMenu', 'selectedLevels', 'level', 'levelsSearch');
});

function formatSalary(input) {
    let value = input.value.replace(/\D/g, '');
    value = value.replace(/\B(?=(\d{3})+(?!\d))/g, '.');
    input.value = value;
}

function validateForm() {
    var skills = document.getElementById('skills').value;
    var benefits = document.getElementById('benefits').value;
    var levels = document.getElementById('level').value;

    var errorMessageSkills = document.getElementById('error-message-skills');
    var errorMessageBenefits = document.getElementById('error-message-benefits');
    var errorMessageLevels = document.getElementById('error-message-levels');

    var valid = true;

    if (!skills) {
        errorMessageSkills.style.display = 'block';
        valid = false;
    } else {
        errorMessageSkills.style.display = 'none';
    }

    if (!benefits) {
        errorMessageBenefits.style.display = 'block';
        valid = false;
    } else {
        errorMessageBenefits.style.display = 'none';
    }

    if (!levels) {
        errorMessageLevels.style.display = 'block';
        valid = false;
    } else {
        errorMessageLevels.style.display = 'none';
    }

    return valid;
}
document.getElementById('startDate').addEventListener('change', function () {
    const startDate = new Date(this.value);
    const endDateInput = document.getElementById('endDate');

    // Ensure endDate is after startDate
    endDateInput.min = this.value;

    if (new Date(endDateInput.value) <= startDate) {
        endDateInput.value = '';
    }
});

document.getElementById('endDate').addEventListener('change', function () {
    const startDate = new Date(document.getElementById('startDate').value);
    const endDate = new Date(this.value);

    if (endDate <= startDate) {
        alert('End date must be after the start date.');
        this.value = '';
    }
});
