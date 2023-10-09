--redmine 144928
--Insert de nuevo comando 7061

DELETE cobis..ba_batch WHERE ba_batch = 7061
go
INSERT INTO cobis..ba_batch VALUES(7061, 'CONSOLIDADOR CARTERA FIN MES', 'CONSOLIDADOR CARTERA FIN MES', 'SP',getdate(),
                                   7, 'P',1,'CARTERA', NULL, 'cob_cartera..sp_consolidador_fin_mes', 1, NULL, 'CTSSRV',
                                   'S',  'C:\Cobis\VBatch\Cartera\Objetos\',NULL)
GO

                                   
                                   