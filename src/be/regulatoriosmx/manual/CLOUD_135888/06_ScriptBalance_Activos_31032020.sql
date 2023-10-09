

exec cob_cartera..sp_boc
     @i_param1 = 1           ,
     @i_param2 = '03/30/2020',
     @i_param3 = 'N'            
     


exec cob_conta_super..sp_ods_balance_activos_ttj
@i_param1 = '03/31/2020'