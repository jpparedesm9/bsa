Imports COBISCorp.tCOBIS.PER.SharedLibrary
Public Class CobisSharedModule
    Inherits COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISModule(Of CobisSharedModule)
    Public Overrides Sub LoadComponent(ByVal sender As Object, ByVal componentEventArgs As COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISComponentEventArgs)
        MCOMMON.MCommonLoad()
        MyBase.LoadComponent(sender, componentEventArgs)
    End Sub
End Class
Public Module SharedFuncionalities
	Public ReadOnly Property FRango() As FRangoClass
		Get
			Return FRangoClass.GetInstance(Of FRangoClass)()
		End Get
	End Property
	Public ReadOnly Property FTipRango() As FTipRangoClass
		Get
			Return FTipRangoClass.GetInstance(Of FTipRangoClass)()
		End Get
	End Property
End Module
