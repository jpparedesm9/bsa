use cobis
go
if object_id('sp_valida_transaccion') is not null
  drop proc sp_valida_transaccion
go

/******************************************************************************/ 
/*    ARCHIVO:         bv_valida_tran.sp                                      */ 
/*    NOMBRE LOGICO:   sp_valida_transaccion                                  */ 
/*    PRODUCTO:        COBIS WEB                                              */ 
/******************************************************************************/ 
/*                     IMPORTANTE                                             */ 
/*   Esta aplicacion es parte de los  paquetes bancarios                      */ 
/*   propiedad de MACOSA S.A.                                                 */ 
/*   Su uso no autorizado queda  expresamente  prohibido                      */ 
/*   asi como cualquier alteracion o agregado hecho  por                      */ 
/*   alguno de sus usuarios sin el debido consentimiento                      */ 
/*   por escrito de MACOSA.                                                   */ 
/*   Este programa esta protegido por la ley de derechos                      */ 
/*   de autor y por las convenciones  internacionales de                      */ 
/*   propiedad intelectual.  Su uso  no  autorizado dara                      */ 
/*   derecho a MACOSA para obtener ordenes  de secuestro                      */ 
/*   o  retencion  y  para  perseguir  penalmente a  los                      */ 
/*   autores de cualquier infraccion.                                         */ 
/******************************************************************************/ 
/*                           PROPOSITO                                        */ 
/*   Verificar que la transacci=n que se realiza por Cobis                    */ 
/*   Internet se encuentre asociada al perfil del cliente		              */
/******************************************************************************/ 
/*                        MODIFICACIONES                                      */ 
/*  FECHA              AUTOR              RAZON                               */ 
/*  20-Oct-1998        Juan Arthos        Emision inicial                     */ 
/*  20/Mar/2002	       D Villafuerte	  Person Bco Tequendama               */
/*  26-Nov-2010        C Echeverrìa       Reentry                             */
/*  18-Jun-2018        Erica Ortega       Integracion con Cash                */
/*  16-Oct-2018        Erica Ortega       Elimación bv_perfil_transaccion     */
/******************************************************************************/ 

CREATE proc sp_valida_transaccion
( 
  @t_trn 		int = null,
  @i_servicio 	tinyint,
  @i_cliente 	int = null,
  @i_perfil 	int = null,
  @i_trn 		int = null,
  @i_login		varchar(64) = null,
  @i_session_id varchar(255) = null,
  @i_noerror    char(1) = 'N
'
) 
as 
  declare @w_msg varchar(60)

-- Validaci=n no aplicable para Cobis IVR
   if @i_servicio is null 
      return 55 

-- Determina servicio habilitado
   if not exists (select 1 from cob_bvirtual..bv_servicio
			where se_servicio = @i_servicio
			
and se_habilitado = 'H')
   begin
 	  exec cobis..sp_cerror 
			@t_from  = 'SERVICIO NO HABILITADO',
			@i_num   = 1850125 
	  return 1
   end

/* Se deja pasar la transaccion si es internet con cliente 0 y perfil 0 */
/* esto se usa para la conformación 
de cheques a usuarios no clientes del banco */
if @i_servicio = 1 and @i_cliente = 0 and @i_perfil = 0
   and (
	@i_trn = 1579 or 	-- consulta de parámetros
	@i_trn = 15226 or 	-- consulta de catalogos
	@i_trn = 18752 or  	-- consulta de cuentas u generación de clave
	@i_trn = 18915) 	-- conformación de cheques
  return 55 
  /*
   -- control del login
   if @i_perfil is null 
 	select @i_perfil = es_perfil
   			from cob_bvirtual..bv_ente_servicio_perfil
   			where es_ente = @i_cliente
   			  and es_se
rvicio  = @i_servicio
   			  and es_estado = 'V'
   			  and es_login  = @i_login

	begin
       -- Valida trn asociada al perfil
       if not exists(select 1 from cob_bvirtual..bv_perfil_funcionalidad a, cob_bvirtual..bv_funcionalidad b , 
            
  
        cob_bvirtual..bv_funcionalidad_transaccion c
					  where ft_funcionalidad = fu_codigo 
                             AND pf_funcionalidad = fu_codigo
                             AND b.fu_estado='V'  
                             AND c.ft_transaccion =@i_trn
                             AND pf_servicio = @i_servicio
                             AND pf_perfil = @i_perfil)
         begin
           select @w_msg = 'TRANSACCION NO AUTORIZADA PERFIL: ' + convert(varchar(10), @i_perfil) + ' TRN: ' + convert(varchar(10), @i_trn)

	      exec cobis..sp_cerror 
			@t_from  = 'sp_valida_transaccion',
			@i_num   = 1875030,
                        @i_msg   = @w_msg,
			@i_sev   = 0
	      return 1
         end 
       end 

    --ini cmeg 26-Nov-2010 
 */  
  
if exists (select ta_transaccion                             
                from cl_trn_atrib                            
                where ta_transaccion=@i_trn
                and ta_graba_log='S')		
                begin        	
                

    select null, null			
                    return 3		
                end

    if exists (select ta_transaccion 		             
               from cl_trn_atrib		              
               where ta_transaccion=@i_trn		               
               and ta_graba_log='A')		
               begin			
                    select null, null			
                    return 4		
               end 

    --fin cmeg 26-Nov-2010 

return 55


