

--parametro dias habiles
   UPDATE cobis..cl_parametro
   SET pa_tinyint=15
   where pa_producto = 'CCA'
   and pa_nemonico = 'DVOG'
   
--truncate
truncate table cob_conta_super..sb_buro_fc_fecha_ult_proc
truncate table cob_conta_super..sb_reporte_buro_final
   