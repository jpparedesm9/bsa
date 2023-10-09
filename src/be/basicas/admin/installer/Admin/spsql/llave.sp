/************************************************************************/
/*      Archivo:                sp_llave.sp			        */
/*      Stored procedure:       sp_llave		                */
/*      Base de datos:          cobis                                   */
/*      Disenado por:  Generador SP                                     */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_llave')
   drop proc sp_llave
go


create proc sp_llave
(
@i_cmd char(1),
@i_nombre varchar(15),
@i_tipo char(1),
@i_estado char(1)=null,
@i_llave binary(16)
)
as

  if exists(select * from ad_llave where ll_nombre=@i_nombre)
   begin
     if @i_cmd!='B'
       update ad_llave
        set ll_tipo=@i_tipo,
            ll_estado=@i_estado,
            ll_llave=@i_llave
        where ll_nombre=@i_nombre
     else
       delete ad_llave where ll_nombre=@i_nombre
    end
  else
   begin
     if @i_cmd='C'
        insert ad_llave values(@i_nombre,@i_tipo,@i_estado,@i_llave)
   end

  return 0
go

