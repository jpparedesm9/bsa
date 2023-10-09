Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Public Class CobisSharedModule
    Inherits COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISModule(Of CobisSharedModule)
    Public Overrides Sub LoadComponent(ByVal sender As Object, ByVal componentEventArgs As COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISComponentEventArgs)
        MCOMMON.MCommonLoad()
        MyBase.LoadComponent(sender, componentEventArgs)
    End Sub
End Class
Public Module SharedFuncionalities
    Public ReadOnly Property FTran230() As FTran230Class
        Get
            Return FTran230Class.GetInstance(Of FTran230Class)()
        End Get
    End Property
    Public ReadOnly Property FBenCta() As FBenCtaClass
        Get
            Return FBenCtaClass.GetInstance(Of FBenCtaClass)()
        End Get
    End Property
    Public ReadOnly Property FImagenes() As FImagenesClass
        Get
            Return FImagenesClass.GetInstance(Of FImagenesClass)()
        End Get
    End Property
    Public ReadOnly Property FMantCatalogo() As FMantCatalogoClass
        Get
            Return FMantCatalogoClass.GetInstance(Of FMantCatalogoClass)()
        End Get
    End Property
End Module
