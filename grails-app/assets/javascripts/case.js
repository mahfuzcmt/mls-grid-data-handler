document.addEventListener("DOMContentLoaded", function() {
    const bankContainer = document.getElementById('banks-container');
    const bankTemplate = document.getElementById('bank-entry-template');
    const addBankButton = document.getElementById('add-bank');

    // Function to add new bank entry
    function addNewBankEntry(bankData = {}) {
        const newBankEntry = bankTemplate.cloneNode(true);
        newBankEntry.style.display = 'flex';
        newBankEntry.removeAttribute('id');

        // Set values if bankData is provided
        newBankEntry.querySelector('input[name="newBanks.name"]').value = bankData.name || '';
        newBankEntry.querySelector('input[name="newBanks.branch"]').value = bankData.branch || '';
        newBankEntry.querySelector('input[name="newBanks.address"]').value = bankData.address || '';
        newBankEntry.querySelector('input[name="newBanks.accountNo"]').value = bankData.accountNo || '';
        newBankEntry.querySelector('input[name="newBanks.holderName"]').value = bankData.holderName || '';
        newBankEntry.querySelector('textarea[name="newBanks.note"]').value = bankData.note || '';

        // Attach remove event
        newBankEntry.querySelector('.remove-bank').addEventListener('click', function() {
            debugger;
            $(this).closest('.bank-entry').remove();
        });

        bankContainer.appendChild(newBankEntry);
    }

    // Add event listener for adding a new bank entry
    addBankButton.addEventListener('click', function() {
        addNewBankEntry();
    });

    // Remove empty bank entries on form submit
    document.querySelector('form').addEventListener('submit', function(event) {
        const bankEntries = Array.from(document.querySelectorAll('.bank-entry'));
        bankEntries.forEach(entry => {
            const inputs = entry.querySelectorAll('input, textarea');
            let empty = true;
            inputs.forEach(input => {
                if (input.value.trim() !== '') {
                    empty = false;
                }
            });
            if (empty) {
                entry.remove();
            }
        });
    });

    // Challans Handling
    const challanContainer = document.getElementById('challans-container');
    const challanTemplate = document.getElementById('challan-entry-template');
    const addChallanButton = document.getElementById('add-challan');

    // Function to add new challan entry
    function addNewChallanEntry(challanData = {}) {
        const newChallanEntry = challanTemplate.cloneNode(true);
        newChallanEntry.style.display = 'flex';
        newChallanEntry.removeAttribute('id');

        // Set values if challanData is provided
        newChallanEntry.querySelector('input[name="newChallans.no"]').value = challanData.no || '';
        newChallanEntry.querySelector('input[name="newChallans.bankName"]').value = challanData.bankName || '';
        newChallanEntry.querySelector('textarea[name="newChallans.note"]').value = challanData.note || '';

        // Attach remove event
        newChallanEntry.querySelector('.remove-challan').addEventListener('click', function() {
            debugger
            $(this).closest('.challan-entry').remove();
        });

        challanContainer.appendChild(newChallanEntry);
    }

    // Add event listener for adding a new challan entry
    addChallanButton.addEventListener('click', function() {
        addNewChallanEntry();
    });

    // Remove empty challan entries on form submit
    document.querySelector('form').addEventListener('submit', function(event) {
        const challanEntries = Array.from(document.querySelectorAll('.challan-entry'));
        challanEntries.forEach(entry => {
            const inputs = entry.querySelectorAll('input, textarea');
            let empty = true;
            inputs.forEach(input => {
                if (input.value.trim() !== '') {
                    empty = false;
                }
            });
            if (empty) {
                entry.remove();
            }
        });
    });
    $(".remove-existing-bank").on("click", function(){
        $(this).closest('.bank-entry').remove();
    })
    $(".remove-existing-bank").on("click", function(){
        $(this).closest('.challan-entry').remove();
    })

});