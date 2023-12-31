
    #region Copyright � 2010 COBIS Corporation.
    /************************************************************/
    /*                     IMPORTANTE                           */
    /*   Esta aplicacion es parte de los  paquetes bancarios    */
    /*   propiedad de COBISCORP.                                */
    /*   Su uso no autorizado queda  expresamente  prohibido    */
    /*   asi como cualquier alteracion o agregado hecho  por    */
    /*   alguno de sus usuarios sin el debido consentimiento    */
    /*   por escrito de COBISCORP.                              */
    /*   Este programa esta protegido por la ley de derechos    */
    /*   de autor  y por las convenciones internacionales de    */
    /*   propiedad intelectual.   Su  uso no autorizado dara    */
    /*   derecho  a   COBISCORP   para  obtener  ordenes  de    */
    /*   secuestro o retencion  y  para perseguir penalmente    */
    /*   a los autores de cualquier infraccion.                 */
    /************************************************************/
    /************************************************************/
    /*   This code was generated by CEN-SG.                     */
    /*   Changes to this file may cause incorrect behavior      */
    /*   and will be lost if the code is regenerated.           */
    /************************************************************/
    #endregion
    using System.Runtime.Serialization;
using COBISCorp.eCOBIS.Commons.DataBinding;
using System.Collections.Generic;
using System.Collections;
using System;
using COBISCorp.eCOBIS.Commons.BLI.DTO;
[assembly: System.Runtime.Serialization.ContractNamespaceAttribute("http://cobiscorp.ecobis.admin.ctascteaho.dto", ClrNamespace="cobiscorp.ecobis.admin.ctascteaho.dto")]

namespace COBISCorp.eCOBIS.Admin.CtasCteAho.DTO
{
  [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "3.0.0.0")] 
  [System.Runtime.Serialization.DataContractAttribute(Namespace= "http://cobiscorp.ecobis.admin.ctascteaho.dto")]
[Serializable]
  public partial class Deposito: ICloneable
    
 {
  public Deposito(){
}
  private string valor;
  private string chequesLocales;
  private string chequesPropios;
  private string chequesPlazas;
  private string total;
  private string actTot;
  private int canal;
  private string numCuenta;
 [System.Runtime.Serialization.DataMemberAttribute(Name = "valor", IsRequired = true, Order =0)] 
  public string  Valor
   {
    get
     {
          return this.valor;
   }
    set
     {
          this.valor=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "chequesLocales", IsRequired = true, Order =0)] 
  public string  ChequesLocales
   {
    get
     {
          return this.chequesLocales;
   }
    set
     {
          this.chequesLocales=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "chequesPropios", IsRequired = true, Order =0)] 
  public string  ChequesPropios
   {
    get
     {
          return this.chequesPropios;
   }
    set
     {
          this.chequesPropios=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "chequesPlazas", IsRequired = true, Order =0)] 
  public string  ChequesPlazas
   {
    get
     {
          return this.chequesPlazas;
   }
    set
     {
          this.chequesPlazas=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "total", IsRequired = true, Order =0)] 
  public string  Total
   {
    get
     {
          return this.total;
   }
    set
     {
          this.total=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "actTot", IsRequired = true, Order =0)] 
  public string  ActTot
   {
    get
     {
          return this.actTot;
   }
    set
     {
          this.actTot=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "canal", IsRequired = true, Order =0)] 
  public int  Canal
   {
    get
     {
          return this.canal;
   }
    set
     {
          this.canal=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "numCuenta", IsRequired = true, Order =0)] 
  public string  NumCuenta
   {
    get
     {
          return this.numCuenta;
   }
    set
     {
          this.numCuenta=value;
   }

 }

    #region ICloneable Members

    public object Clone()
    {
    return this.MemberwiseClone();
    }

    #endregion
    
 }
}