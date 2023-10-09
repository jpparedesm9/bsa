
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
  public partial class Retiro: ICloneable
    
 {
  public Retiro(){
}
  private string terminal;
  private string fecha;
  private int rol;
  private int oficina;
  private string organizacion;
  private string srv;
  private string lsrv;
  private string usuario;
  private string trn;
  private string numCuenta;
  private int moneda;
  private string valor;
  private string actTot;
  private int canal;
  private int ssn;
 [System.Runtime.Serialization.DataMemberAttribute(Name = "terminal", IsRequired = true, Order =0)] 
  public string  Terminal
   {
    get
     {
          return this.terminal;
   }
    set
     {
          this.terminal=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "fecha", IsRequired = true, Order =0)] 
  public string  Fecha
   {
    get
     {
          return this.fecha;
   }
    set
     {
          this.fecha=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "rol", IsRequired = true, Order =0)] 
  public int  Rol
   {
    get
     {
          return this.rol;
   }
    set
     {
          this.rol=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "oficina", IsRequired = true, Order =0)] 
  public int  Oficina
   {
    get
     {
          return this.oficina;
   }
    set
     {
          this.oficina=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "organizacion", IsRequired = true, Order =0)] 
  public string  Organizacion
   {
    get
     {
          return this.organizacion;
   }
    set
     {
          this.organizacion=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "srv", IsRequired = true, Order =0)] 
  public string  Srv
   {
    get
     {
          return this.srv;
   }
    set
     {
          this.srv=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "lsrv", IsRequired = true, Order =0)] 
  public string  Lsrv
   {
    get
     {
          return this.lsrv;
   }
    set
     {
          this.lsrv=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "usuario", IsRequired = true, Order =0)] 
  public string  Usuario
   {
    get
     {
          return this.usuario;
   }
    set
     {
          this.usuario=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "trn", IsRequired = true, Order =0)] 
  public string  Trn
   {
    get
     {
          return this.trn;
   }
    set
     {
          this.trn=value;
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
 [System.Runtime.Serialization.DataMemberAttribute(Name = "moneda", IsRequired = true, Order =0)] 
  public int  Moneda
   {
    get
     {
          return this.moneda;
   }
    set
     {
          this.moneda=value;
   }

 }
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
 [System.Runtime.Serialization.DataMemberAttribute(Name = "ssn", IsRequired = true, Order =0)] 
  public int  Ssn
   {
    get
     {
          return this.ssn;
   }
    set
     {
          this.ssn=value;
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