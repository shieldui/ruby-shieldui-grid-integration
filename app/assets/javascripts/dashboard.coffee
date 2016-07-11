$ ->
  $('#expenses').shieldGrid
    dataSource:
      schema:
        fields:
          id: { path: 'id', type: Number }
          date: { path: 'date', type: Date }
          title: { path: 'title', type: String }
          amount: { path: 'amount', type: Number }
      remote:
        read: '/expenses.json'
        modify:
          create: (items, success, error) ->
            newItem = items[0]
            $.ajax
              url: '/expenses'
              type: 'POST'
              dataType: 'json'
              data: { expense: newItem.data }
              complete: (xhr) ->
                if xhr.readyState == 4 and xhr.status == 201
                  newItem.data.id = xhr.responseJSON.id
                  return success()
                error()
          update: (items, success, error) ->
            newItem = items[0]
            $.ajax
              url: "/expenses/#{newItem.data.id}"
              type: 'PUT'
              dataType: 'json'
              data: { expense: newItem.data }
            .then(success, error)
          remove: (items, success, error) ->
            newItem = items[0]
            $.ajax
              url: "/expenses/#{newItem.data.id}"
              type: 'DELETE'
              dataType: 'json'
            .then(success, error)
    paging: true
    sorting: true
    columns: [
      { field: 'date', title: 'Date', width: 100, format: "{0:MM/dd/yyyy}" },
      { field: 'title', title: 'Title', width: 200 },
      { field: 'amount', title: 'Amount', width: 80 },
      {
        title: 'Actions',
        width: 70,
        buttons: [
          { cls: 'editButton', commandName: 'edit', caption: 'Edit' }
          { cls: 'deleteButton', commandName: 'delete', caption: 'Delete' }
        ]
      }
    ]
    editing:
      enabled: true
      type: 'row'
      confirmation:
        delete:
          enabled: true
          template: (item) ->
            "Are you sure you want to delete expense \"#{item.title}\"?"
    toolbar: [
      {
        buttons: [
          commandName: 'insert'
          caption: 'Add Expense'
        ]
        position: 'top'
      }
    ]
