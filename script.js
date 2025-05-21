window.onload = () => {
    
    fetch('https://leonnaviegas.dev.br/apilc/gastos', {
        method: 'GET'
      })
      .then((response) => {
        loadItens(JSON.parse(response));
        form.reset();
      })
      .catch(err => {
        console.error('Erro na requisição:', err);
      });

    let checks = document.getElementsByTagName('input');
    for (let i=0; i<checks.length; i++) {
        if (checks.item(i).type == "checkbox") {
            checks.item(i).checked = false;
        }
    }
}


function change(id) {
    let table = document.getElementById('tabela');
    let tr = table.rows[id];
    if (tr.classList.contains('strikeout')) {
        tr.classList.remove('strikeout');
    } else {
        tr.classList.add('strikeout');
    }
}

document.getElementById('btnAddItem').onclick = openAddModal;

function openAddModal() {
    document.getElementById('modalAdd').open = !document.getElementById('modalAdd').open;
}

function loadItens(array) {
    for (let i = 0; i<array.length; i++) {
        addItemTable(array[i].produto,array[i].quantia)
    }
}

function addItemTable(name, qtd) {
    let table = document.getElementById('tabela');
    let newRow = table.insertRow();
    let columns = [
        `<input class="checkbox" type="checkbox" onclick="change(${table.rows.length-1})">`,
        name,
        qtd,
        `<button class="btn edit" onclick="editItem(${table.rows.length-1})"></button><button class="btn remove" onclick="removeItem(${table.rows.length-1})"></button>`
    ];
    for (let i = 0; i<4; i++) {
        let newColumn=newRow.insertCell();
        newColumn.innerHTML = columns[i];
    }
}

function editItem(index) {
    let table = document.getElementById('tabela');
    let row = table.rows[index];
    let name = row.children[1];
    let qtd = row.children[2];
    let btn = row.children[3].children[0];
    btn.classList.add('accept');
    btn.setAttribute('onclick','finalizeEditItem('+index+')');
    name.contentEditable = true;
    qtd.contentEditable = true;
}

function finalizeEditItem(index) {
    let table = document.getElementById('tabela');
    let row = table.rows[index];
    let name = row.children[1];
    let qtd = row.children[2];
    let btn = row.children[3].children[0];
    btn.classList.remove('accept');
    btn.setAttribute('onclick','editItem('+index+')');
    name.contentEditable = false;
    qtd.contentEditable = false;
}

function removeItem(index) {
    let table = document.getElementById('tabela');
    let row = table.rows[index];
    let btn = row.children[3].children[1];
    btn.classList.add('accept');
    btn.setAttribute('onclick','removeRowTable('+index+')');
}

function removeRowTable(index) {
    let table = document.getElementById('tabela');
    table.deleteRow(index);
    resetHardValues();
}

function resetHardValues() {
    let table = document.getElementById('tabela');
    for (let i=1; i<table.rows.length; i++) {
        let row = table.rows[i];
        let btnDiv = row.children[3];
        let btnEdit = btnDiv.children[0];
        let btnRemove = btnDiv.children[1];
        btnEdit.setAttribute('onclick', 'editItem('+i+')');
        btnRemove.setAttribute('onclick', 'removeItem('+i+')');
    }
}

const form = document.getElementById('addForm');

  form.addEventListener('submit', function (e) {
    e.preventDefault();

    const formData = new FormData(form);
    const data = Object.fromEntries(formData.entries());

    var today = new Date();
    var dd = String(today.getDate()).padStart(2, '0');
    var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
    var yyyy = today.getFullYear();

    today = yyyy + '-' + mm + '-' + dd;

    let a = yyyy + '-' + mm + '-' + dd;

    fetch('https://leonnaviegas.dev.br/apilc/gastos', {
      method: 'POST',
      body: JSON.stringify({nome:data.nome, qtd:data.qtd, dt:a, user:""}),
    })
    .then(() => {
      // Só vai cair aqui se não der erro de rede
      // Você NÃO CONSEGUE acessar o conteúdo da resposta com 'no-cors'
      addItemTable(data.nome, data.qtd);
      openAddModal();
      form.reset();
    })
    .catch(err => {
      console.error('Erro na requisição:', err);
    });
  });