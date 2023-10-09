/*************************************************************************************/
/* Archivo:     cl_ente_u_tg.sp                                                      */
/* Trigger:     tgu_cl_ente                                                          */
/* Producto:    ADMINISTRACION                                                       */
/*************************************************************************************/
/*                                 IMPORTANTE                                        */
/* Este programa es parte de los paquetes bancarios propiedad de COBISCorp.          */
/* Su uso no autorizado queda expresamente prohibido asi como cualquier              */
/* alteracion o agregado hecho por alguno de usuarios sin el debido                  */
/* consentimiento por escrito de la Presidencia Ejecutiva de COBISCorp               */
/* o su representante.                                                               */
/*************************************************************************************/
/*                                PROPOSITO                                          */
/* Disparador de informacion de errores                                              */
/*************************************************************************************/
/*                                MODIFICACIONES                                     */
/*************************************************************************************/
/* FECHA        VERSION  AUTOR   RAZON                                               */
/*************************************************************************************/
/* 29-Ene-2020  1.0.0.0  ACH     Para obtener info sobre CURP y RFC gen identicamente*/
/*************************************************************************************/

use cobis
go
if exists (select 1 from sysobjects where name = 'tgu_cl_ente')
    drop trigger tgu_cl_ente
go
create trigger tgu_cl_ente

on cl_ente

 FOR INSERT, UPDATE, DELETE
 
as

declare 
@UserName      varchar(128),
@Type          char(1),
@w_ced_ruc     varchar(30),--curp
@w_rfc         varchar(30),--rfc
@s_user        varchar(30)

begin
    if update (en_nit) or  update (en_ced_ruc) or update (en_rfc)
    begin
        select @UserName = system_user
        
        if exists(select 1 from inserted)
        if exists(select 1 from deleted)      
        select @Type = 'U'
        else   SELECT @Type = 'I'
        else   SELECT @Type = 'D'
        
        select @w_ced_ruc = en_ced_ruc,
               @w_rfc     = en_rfc
        from   inserted

        if (len(@w_ced_ruc) < 18)
         begin
               insert into cl_modificacion_curp_rfc
               select I.en_ente,    --mcr_ente
                      @UserName,    --mcr_ssn_user
                      0,            --mcr_ssn_oficina
                      getdate(),    --mcr_fecha
                      0,            --mcr_oficial, 
                      0,            --mcr_oficina, 
                      D.en_ced_ruc, --mcr_curp_ant, --
                      D.en_rfc,     --mcr_rfc_ant
                      I.en_ced_ruc, --mcr_curp
                      I.en_rfc,     --mcr_rfc
                      @Type,        --mcr_operacion
                      host_name() + '-'+ APP_NAME() + '-'+ system_user + '-' +isnull(@s_user,'base') --mcr_sp
               from   inserted I, deleted  D
               where  I.en_ente = D.en_ente
        end
    end
end
go