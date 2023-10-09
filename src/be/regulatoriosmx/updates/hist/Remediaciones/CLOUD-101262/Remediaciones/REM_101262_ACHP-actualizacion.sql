  --Buenas tardes
  --
  --Se solicita quitar el estatus RECHAZADO que el gerente aplico por equivocación, el grupo y solicitud son los siguientes:
  --
  --GRUPO MIS GUERRERAS
  --SOL SOLCRGRSTD.2381.18.000001
  --
  --SALUDOS

update cob_credito..cr_tramite
set    tr_estado = 'P'
where tr_tramite = 4403
