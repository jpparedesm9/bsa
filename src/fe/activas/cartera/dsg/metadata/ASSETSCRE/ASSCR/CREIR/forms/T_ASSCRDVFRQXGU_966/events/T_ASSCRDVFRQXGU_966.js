//"TaskId": "T_ASSCRDVFRQXGU_966"
task.closeModalEvent.findCustomer = function (args) {
  var resp = args.commons.api.vc.dialogParameters;
  var customerCode = resp.CodeReceive;
  customerName = resp.name;
  // args.model.LoginCallCenter.idClient = customerCode + " - " + CustomerName;
  args.model.LoginCallCenter.idCliente = customerCode;


};

