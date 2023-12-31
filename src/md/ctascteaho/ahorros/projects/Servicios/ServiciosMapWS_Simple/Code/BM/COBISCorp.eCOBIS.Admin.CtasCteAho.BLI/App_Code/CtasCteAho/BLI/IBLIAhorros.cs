
    #region Copyright (c) 2010 COBIS Corporation.
    /************************************************************/
    /*                     IMPORTANTE                           */
    /*   Esta aplicacion es parte de los  paquetes bancarios    */
    /*   propiedad de COBISCORP.                                */
    /*   Su uso no autorizado queda  expresamente  prohibido    */
    /*   asi como cualquier alteracion o agregado hecho  por    */
    /*   alguno de sus usuarios sin el debido consentimiento    */
    /*   por escrito de COBISCORP.                              */
    /*   Este programa esta protegido por la ley de derechos    */
    /*   de autor y por las y por las convenciones              */
    /*   internacionales de  propiedad intelectual. Su uso no   */
    /*   autorizado dara  derecho a  COBISCORP para obtener     */
    /*   ordenes de  secuestro o retencion y  para perseguir    */
    /*   penalmente a los autores de cualquier infraccion.      */
    /************************************************************/
    /*   This code was generated by CEN-SG.                     */
    /*   Changes to this file may cause incorrect behavior      */
    /*   and will be lost if the code is regenerated.           */
    /************************************************************/
    #endregion
    using System.Collections.Generic;
    using System.Collections;
    using COBISCorp.eCOBIS.Commons.BLI.DTO;
    using ns0 = COBISCorp.eCOBIS.Admin.CtasCteAho.DTO;
        
    namespace COBISCorp.eCOBIS.Admin.CtasCteAho.BLI
    {
    public interface IBLIAhorros
    {
    
      /// <summary>
      /// 
      /// </summary>
      ns0.ConsultaMovimientosResponse ConsultaMovimientos(ns0.ConsultaMovimientoRequest inConsultaMovimientoRequest);
    
      /// <summary>
      /// 
      /// </summary>
      ns0.SaldoYPromedioResponse ConsultaSaldosYPromedios(ns0.SaldoYPromedioRequest inSaldoYPromedioRequest);
    
      /// <summary>
      /// 
      /// </summary>
      ns0.RegistroDelDepositoResponse RegistroDelDeposito(ns0.RegistroDelDepositoRequest inRegistroDelDepositoRequest);
    
      /// <summary>
      /// 
      /// </summary>
      ns0.RetiroResponse RetiroAhorros(ns0.RetiroRequest inRetiroRequest);
    
    }
    }
  