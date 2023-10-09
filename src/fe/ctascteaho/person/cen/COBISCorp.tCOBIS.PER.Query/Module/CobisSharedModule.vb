Imports COBISCorp.tCOBIS.PER.SharedLibrary
Public Class CobisSharedModule
    Inherits COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISModule(Of CobisSharedModule)
    Public Overrides Sub LoadComponent(ByVal sender As Object, ByVal componentEventArgs As COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISComponentEventArgs)
        MCOMMON.MCommonLoad()
        MyBase.LoadComponent(sender, componentEventArgs)
    End Sub
End Class
Public Module SharedFuncionalities
	Public ReadOnly Property FCatalogoServ() As FCatalogoServClass
		Get
			Return FCatalogoServClass.GetInstance(Of FCatalogoServClass)()
		End Get
	End Property
	Public ReadOnly Property FConsultaCta() As FConsultaCtaClass
		Get
			Return FConsultaCtaClass.GetInstance(Of FConsultaCtaClass)()
		End Get
	End Property
End Module
