DROP TABLE PCL_DESEMBOLSO
GO

CREATE TABLE PCL_DESEMBOLSO (linea_dato VARCHAR(1100))
GO

INSERT INTO PCL_DESEMBOLSO VALUES('01000000160014E204000012017121301001                                                                                                                                                                                                                                                                                                                                                                                                                                                              ')
INSERT INTO PCL_DESEMBOLSO VALUES('020000002600120171213014014000000000000100                98201712130100000000065506361908SANTANDER INCLUSION FINANCIERA SA de CV SIF170801PYA      0100000000025000137944ALAN FRAUSTO ROJO                       SIF170801PYA                                                                                      0000000000000000000001CREDITO 2251                                                          0020171213            DEPOSITO CREDITO 2251         ABONO TUIIO                   fra@hotmail.com                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ')
INSERT INTO PCL_DESEMBOLSO VALUES('020000003600120171213014014000000000000100                98201712130100000000065506361908SANTANDER INCLUSION FINANCIERA SA de CV SIF170801PYA      0100000000000000000000ALAN FRAUSTO ROJO                       SIF170801PYA                                                                                      0000000000000000000001CREDITO 2251                                                          0020171213            DEPOSITO CREDITO 2251         ABONO TUIIO                   paul.clavijo@cobiscorp.com                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              ')
INSERT INTO PCL_DESEMBOLSO VALUES('0900000046004000010000002000000000000000200                                                                                                                                                                                                                                                                                                                                                                                                                                                       ')
GO

SELECT * FROM PCL_DESEMBOLSO
--EXEC cob_cartera..sp_help ca_santander_orden_deposito