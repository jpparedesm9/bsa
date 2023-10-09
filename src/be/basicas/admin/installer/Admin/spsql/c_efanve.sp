/******************************************************************/
/*  Archivo:              c_efanve.sp                             */
/*  Stored procedure:     sp_convierte_efectiva_antven            */
/*  Base de datos:        cob_tesoreria                           */
/*  Producto:             TESORERIA                               */
/*  Disenado por:         Nancy Usina                             */
/*  Fecha:                04-Ene-99                               */
/******************************************************************/
/*                         IMPORTANTE                             */
/*  Esta Aplicacion es parte de los paquetes bancarios propiedad  */
/*  de MACOSA, representantes exclusivos para  el Ecuador de  la  */
/*  NCR CORPORATION.  Su uso  no  autorizado queda  expresamente  */
/*  prohibido asi como cualquier alteracion o agregado hecho por  */
/*  alguno  de sus  usuarios  sin el debido  consentimiento  por  */
/*  escrito  de  la   Presidencia  Ejecutiva   de  MACOSA  o  su  */
/*  representante                                                 */
/******************************************************************/
/*                          PROPOSITO                             */
/*	Este proceso se encarga de convertir cualquier tasa 	  */
/*	efectiva a una tasa periódica en cualquier modalidad	  */
/******************************************************************/
/*                       MODIFICACIONES                           */
/*  FECHA          AUTOR           RAZON                          */
/*	04-Ene-99	Juan C. Gómez	Emisión Inicial		  */   
/*  03-Jun-1999 N. Silva        Correcciones formulas             */
/******************************************************************/


use cobis
go

if exists (select * from sysobjects where name = 'sp_convierte_efectiva_antven')
        drop proc sp_convierte_efectiva_antven
go


create proc sp_convierte_efectiva_antven (
	@s_ssn			int,
	@s_user			varchar(30),
	@s_term			varchar(10),
	@s_date			datetime,
	@s_srv			varchar(30),
	@s_lsrv			varchar(30),
	@s_rol			smallint = 1,
	@s_ofi			smallint,
	@s_org_err		char(1)  = null,
	@s_error		int      = null,
	@s_sev			tinyint  = null,
	@s_msg			mensaje  = null,
	@s_org          	char(1),
	@t_debug		char(1) = 'N',
	@t_file			char(1) =  null,
        @t_from         	char(1) = null,
	@t_trn			smallint,
        @i_tasa_efectiva	float,    
	@i_modalidad		char(1),
	@i_periodo		int,
	@i_base_calculo 	int,
	@o_tasa_convrndt	float = null out
)
as

declare @w_mensaje	varchar(80),
        @w_sp_name	varchar(30),
        @w_return	smallint,
        @w_n		int,
	@w_tper		float,
	@w_aux		float,
	@w_tasa_conv	float,
	@w_per_anual	int
         
	select @w_sp_name='sp_convierte_efectiva_antven'

	/*Encontrar el número de periodos del año*/

	if (@i_base_calculo = 360 OR @i_base_calculo = 365)
	begin
		select @w_per_anual = @i_base_calculo
		select @w_n = @w_per_anual / @i_periodo
		if @i_modalidad = 'A'
		begin
			select @w_tper = @i_tasa_efectiva
			select @w_aux = power((1+(@w_tper/100.0)),(1.0/@w_n))
			select @w_tasa_conv = (1-(1/@w_aux))*@w_n
		end
		else
		begin
			select @w_tper = @i_tasa_efectiva
			select @w_aux = power((1+(@w_tper/100.0)),(1.0/@w_n))
			select @w_tasa_conv = (@w_aux - 1) * @w_n
		end
		
		/*Asigno a la variable de output el valor de la tasa resultante*/
		
		select @o_tasa_convrndt = @w_tasa_conv * 100

		return 0
	end
	else
	begin
		exec sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 99999,
	   		@i_sev	 = 0,
	   		@i_msg	 = 'El valor de base de calculo debe ser 360 o 365'
		return 1
	end
go