USE cob_cartera
GO

   UPDATE ca_corresponsal_trn 
      SET co_estado    = 'X'
    where co_codigo_interno = IN ( 34840,42241, 45996, 50156, 60044, 61786, 83347, 124391, 126989, 134084, 150281,152263,  182909 ) --143713
      AND co_estado = 'I'
      AND co_accion = 'I'
      AND co_tipo   = 'PG'

go



