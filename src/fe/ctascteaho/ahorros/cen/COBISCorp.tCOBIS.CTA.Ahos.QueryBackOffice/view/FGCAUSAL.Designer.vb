Imports COBISCorp.tCOBIS.CTA.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
 Partial   Class FBusCausalClass
#Region "Windows Form Designer generated code "
	Public Sub New()
		MyBase.New()
		isInitializingComponent = True
		InitializeComponent()
		isInitializingComponent = False
		InitializeoptOpcion()
		InitializelblTitulo()
		InitializecmdBoton()
	End Sub
    Private Sub ReleaseResources(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Closed
        Dispose(True)
    End Sub
    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
     Protected Overloads Overrides Sub Dispose(ByVal Disposing As Boolean)
        If Disposing Then
            If Not (components Is Nothing) Then
                components.Dispose()
            End If
        End If
        MyBase.Dispose(Disposing)
    End Sub
    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer
    Friend WithEvents COBISViewResizer As COBISCorp.eCOBIS.Commons.COBISViewResizer
    Friend WithEvents COBISStyleProvider As COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider
    Public WithEvents COBISResourceProvider As COBISCorp.Framework.UI.Components.COBISResourceProvider
    Public ToolTip1 As System.Windows.Forms.ToolTip
    Public WithEvents txtCampo As System.Windows.Forms.TextBox
    Private WithEvents _optOpcion_1 As System.Windows.Forms.RadioButton
    Private WithEvents _optOpcion_0 As System.Windows.Forms.RadioButton
    Public WithEvents grdCausales As COBISCorp.Framework.UI.Components.COBISGrid
    Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_4 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_3 As System.Windows.Forms.Button
    Private WithEvents _lblTitulo_3 As System.Windows.Forms.Label
    Private WithEvents _lblTitulo_2 As System.Windows.Forms.Label
    Private WithEvents _lblTitulo_1 As System.Windows.Forms.Label
    Public cmdBoton(4) As System.Windows.Forms.Button
    Public lblTitulo(3) As System.Windows.Forms.Label
    Public linLinea(2) As System.Windows.Forms.Label
    Public optOpcion(1) As System.Windows.Forms.RadioButton
    Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
     Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FBusCausalClass))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.txtCampo = New System.Windows.Forms.TextBox()
        Me._optOpcion_1 = New System.Windows.Forms.RadioButton()
        Me._optOpcion_0 = New System.Windows.Forms.RadioButton()
        Me.grdCausales = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me._cmdBoton_1 = New System.Windows.Forms.Button()
        Me._cmdBoton_4 = New System.Windows.Forms.Button()
        Me._cmdBoton_2 = New System.Windows.Forms.Button()
        Me._cmdBoton_3 = New System.Windows.Forms.Button()
        Me._lblTitulo_3 = New System.Windows.Forms.Label()
        Me._lblTitulo_2 = New System.Windows.Forms.Label()
        Me._lblTitulo_1 = New System.Windows.Forms.Label()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.GBCausales = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSiguiente = New System.Windows.Forms.ToolStripButton()
        Me.TSBEscoger = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me.grdCausales, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
        CType(Me.GBCausales, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GBCausales.SuspendLayout()
        Me.TSBotones.SuspendLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'COBISViewResizer
        '
        Me.COBISViewResizer.AutoRelocateControls = False
        Me.COBISViewResizer.AutoResizeControls = False
        Me.COBISViewResizer.ContainerForm = Me
        Me.COBISViewResizer.EnabledResize = True
        '
        'txtCampo
        '
        Me.txtCampo.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtCampo, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtCampo, False)
        Me.txtCampo.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtCampo, "Default")
        Me.txtCampo.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtCampo.Location = New System.Drawing.Point(165, 33)
        Me.txtCampo.MaxLength = 30
        Me.txtCampo.Name = "txtCampo"
        Me.txtCampo.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtCampo.Size = New System.Drawing.Size(333, 20)
        Me.txtCampo.TabIndex = 2
        Me.txtCampo.Text = "%"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtCampo, "")
        '
        '_optOpcion_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optOpcion_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._optOpcion_1, False)
        Me._optOpcion_1.AutoSize = True
        Me._optOpcion_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optOpcion_1, "Default")
        Me._optOpcion_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._optOpcion_1.ForeColor = System.Drawing.Color.Navy
        Me._optOpcion_1.Location = New System.Drawing.Point(49, 44)
        Me._optOpcion_1.Name = "_optOpcion_1"
        Me.COBISResourceProvider.SetResourceID(Me._optOpcion_1, "2401")
        Me._optOpcion_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optOpcion_1.Size = New System.Drawing.Size(73, 17)
        Me._optOpcion_1.TabIndex = 1
        Me._optOpcion_1.Text = "*Nombre"
        Me._optOpcion_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optOpcion_1, "")
        '
        '_optOpcion_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optOpcion_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._optOpcion_0, False)
        Me._optOpcion_0.AutoSize = True
        Me._optOpcion_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optOpcion_0, "Default")
        Me._optOpcion_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._optOpcion_0.ForeColor = System.Drawing.Color.Navy
        Me._optOpcion_0.Location = New System.Drawing.Point(49, 27)
        Me._optOpcion_0.Name = "_optOpcion_0"
        Me.COBISResourceProvider.SetResourceID(Me._optOpcion_0, "500230")
        Me._optOpcion_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optOpcion_0.Size = New System.Drawing.Size(69, 17)
        Me._optOpcion_0.TabIndex = 0
        Me._optOpcion_0.TabStop = True
        Me._optOpcion_0.Text = "*Código"
        Me._optOpcion_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optOpcion_0, "")
        '
        'grdCausales
        '
        Me.grdCausales._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdCausales, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdCausales, False)
        Me.grdCausales.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdCausales.Clip = ""
        Me.grdCausales.Col = CType(1, Short)
        Me.grdCausales.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdCausales.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdCausales.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdCausales, "Default")
        Me.grdCausales.CtlText = ""
        Me.grdCausales.Dock = System.Windows.Forms.DockStyle.Fill
        Me.COBISStyleProvider.SetEnableStyle(Me.grdCausales, True)
        Me.grdCausales.FixedCols = CType(1, Short)
        Me.grdCausales.FixedRows = CType(1, Short)
        Me.grdCausales.ForeColor = System.Drawing.Color.Black
        Me.grdCausales.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdCausales.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdCausales.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdCausales.HighLight = True
        Me.grdCausales.Location = New System.Drawing.Point(3, 16)
        Me.grdCausales.Name = "grdCausales"
        Me.grdCausales.Picture = Nothing
        Me.grdCausales.Row = CType(1, Short)
        Me.grdCausales.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdCausales.Size = New System.Drawing.Size(485, 195)
        Me.grdCausales.Sort = CType(2, Short)
        Me.grdCausales.TabIndex = 3
        Me.grdCausales.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdCausales, "")
        '
        '_cmdBoton_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_0, False)
        Me._cmdBoton_0.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_0, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_0, True)
        Me._cmdBoton_0.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_0, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_0, Nothing)
        Me._cmdBoton_0.Enabled = False
        Me._cmdBoton_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_0.Image = CType(resources.GetObject("_cmdBoton_0.Image"), System.Drawing.Image)
        Me._cmdBoton_0.ImageAlign = System.Drawing.ContentAlignment.TopCenter
        Me._cmdBoton_0.Location = New System.Drawing.Point(-496, 1)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(58, 57)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 4
        Me._cmdBoton_0.Tag = "15044"
        Me._cmdBoton_0.Text = "&Buscar"
        Me._cmdBoton_0.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_0.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_0, "")
        '
        '_cmdBoton_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_1, False)
        Me._cmdBoton_1.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_1, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_1, True)
        Me._cmdBoton_1.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_1, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_1, Nothing)
        Me._cmdBoton_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_1.Image = CType(resources.GetObject("_cmdBoton_1.Image"), System.Drawing.Image)
        Me._cmdBoton_1.ImageAlign = System.Drawing.ContentAlignment.TopCenter
        Me._cmdBoton_1.Location = New System.Drawing.Point(-496, 59)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_1, System.Drawing.Color.Silver)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(58, 57)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_1, 1)
        Me._cmdBoton_1.TabIndex = 5
        Me._cmdBoton_1.Text = "Si&guiente"
        Me._cmdBoton_1.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_1.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_1, "")
        '
        '_cmdBoton_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_4, False)
        Me._cmdBoton_4.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_4, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_4, True)
        Me._cmdBoton_4.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_4, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_4, Nothing)
        Me._cmdBoton_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_4.Image = CType(resources.GetObject("_cmdBoton_4.Image"), System.Drawing.Image)
        Me._cmdBoton_4.ImageAlign = System.Drawing.ContentAlignment.TopCenter
        Me._cmdBoton_4.Location = New System.Drawing.Point(-496, 236)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_4, System.Drawing.Color.Silver)
        Me._cmdBoton_4.Name = "_cmdBoton_4"
        Me._cmdBoton_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_4.Size = New System.Drawing.Size(58, 57)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_4, 1)
        Me._cmdBoton_4.TabIndex = 8
        Me._cmdBoton_4.Text = "&Salir"
        Me._cmdBoton_4.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_4.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_4.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_4, "")
        '
        '_cmdBoton_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_2, False)
        Me._cmdBoton_2.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_2, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_2, True)
        Me._cmdBoton_2.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_2, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_2, Nothing)
        Me._cmdBoton_2.Enabled = False
        Me._cmdBoton_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_2.Image = CType(resources.GetObject("_cmdBoton_2.Image"), System.Drawing.Image)
        Me._cmdBoton_2.ImageAlign = System.Drawing.ContentAlignment.TopCenter
        Me._cmdBoton_2.Location = New System.Drawing.Point(-496, 147)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_2, System.Drawing.Color.Silver)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(58, 57)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_2, 1)
        Me._cmdBoton_2.TabIndex = 6
        Me._cmdBoton_2.Tag = "15042"
        Me._cmdBoton_2.Text = "&Escoger"
        Me._cmdBoton_2.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_2.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_2, "")
        '
        '_cmdBoton_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_3, False)
        Me._cmdBoton_3.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_3, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_3, True)
        Me._cmdBoton_3.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_3, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_3, Nothing)
        Me._cmdBoton_3.Enabled = False
        Me._cmdBoton_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_3.Image = CType(resources.GetObject("_cmdBoton_3.Image"), System.Drawing.Image)
        Me._cmdBoton_3.ImageAlign = System.Drawing.ContentAlignment.TopCenter
        Me._cmdBoton_3.Location = New System.Drawing.Point(-496, 147)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_3, System.Drawing.Color.Silver)
        Me._cmdBoton_3.Name = "_cmdBoton_3"
        Me._cmdBoton_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_3.Size = New System.Drawing.Size(58, 57)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_3, 1)
        Me._cmdBoton_3.TabIndex = 7
        Me._cmdBoton_3.Tag = "542"
        Me._cmdBoton_3.Text = "&Eliminar"
        Me._cmdBoton_3.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_3.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_3, "")
        '
        '_lblTitulo_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblTitulo_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblTitulo_3, False)
        Me._lblTitulo_3.AutoSize = True
        Me._lblTitulo_3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblTitulo_3, "Default")
        Me._lblTitulo_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblTitulo_3.ForeColor = System.Drawing.Color.Navy
        Me._lblTitulo_3.Location = New System.Drawing.Point(289, 10)
        Me._lblTitulo_3.Name = "_lblTitulo_3"
        Me.COBISResourceProvider.SetResourceID(Me._lblTitulo_3, "500232")
        Me._lblTitulo_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblTitulo_3.Size = New System.Drawing.Size(71, 13)
        Me._lblTitulo_3.TabIndex = 12
        Me._lblTitulo_3.Text = "*[Código] : "
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblTitulo_3, "")
        '
        '_lblTitulo_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblTitulo_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblTitulo_2, False)
        Me._lblTitulo_2.AutoSize = True
        Me._lblTitulo_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblTitulo_2, "Default")
        Me._lblTitulo_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblTitulo_2.ForeColor = System.Drawing.Color.Navy
        Me._lblTitulo_2.Location = New System.Drawing.Point(167, 10)
        Me._lblTitulo_2.Name = "_lblTitulo_2"
        Me.COBISResourceProvider.SetResourceID(Me._lblTitulo_2, "500233")
        Me._lblTitulo_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblTitulo_2.Size = New System.Drawing.Size(123, 13)
        Me._lblTitulo_2.TabIndex = 11
        Me._lblTitulo_2.Text = "*Valor de Búsqueda "
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblTitulo_2, "")
        '
        '_lblTitulo_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblTitulo_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblTitulo_1, False)
        Me._lblTitulo_1.AutoSize = True
        Me._lblTitulo_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblTitulo_1, "Default")
        Me._lblTitulo_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblTitulo_1.ForeColor = System.Drawing.Color.Navy
        Me._lblTitulo_1.Location = New System.Drawing.Point(10, 10)
        Me._lblTitulo_1.Name = "_lblTitulo_1"
        Me.COBISResourceProvider.SetResourceID(Me._lblTitulo_1, "500234")
        Me._lblTitulo_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblTitulo_1.Size = New System.Drawing.Size(154, 13)
        Me._lblTitulo_1.TabIndex = 10
        Me._lblTitulo_1.Text = "*Condición de Búsqueda :"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblTitulo_1, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.GBCausales)
        Me.PFormas.Controls.Add(Me.txtCampo)
        Me.PFormas.Controls.Add(Me._optOpcion_1)
        Me.PFormas.Controls.Add(Me._lblTitulo_1)
        Me.PFormas.Controls.Add(Me._optOpcion_0)
        Me.PFormas.Controls.Add(Me._lblTitulo_2)
        Me.PFormas.Controls.Add(Me._lblTitulo_3)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(511, 289)
        Me.PFormas.TabIndex = 16
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'GBCausales
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GBCausales, False)
        Me.COBISViewResizer.SetAutoResize(Me.GBCausales, False)
        Me.GBCausales.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.GBCausales.Controls.Add(Me.grdCausales)
        Me.COBISStyleProvider.SetControlStyle(Me.GBCausales, "Default")
        Me.GBCausales.ForeColor = System.Drawing.Color.Navy
        Me.GBCausales.Location = New System.Drawing.Point(10, 67)
        Me.GBCausales.Name = "GBCausales"
        Me.COBISResourceProvider.SetResourceID(Me.GBCausales, "508452")
        Me.GBCausales.Size = New System.Drawing.Size(491, 214)
        Me.GBCausales.TabIndex = 13
        Me.GBCausales.Text = "*Causales"
        Me.GBCausales.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GBCausales, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBuscar, Me.TSBSiguiente, Me.TSBEscoger, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(531, 25)
        Me.TSBotones.TabIndex = 17
        Me.TSBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBotones, "")
        '
        'TSBBuscar
        '
        Me.TSBBuscar.ForeColor = System.Drawing.Color.Black
        Me.TSBBuscar.Image = CType(resources.GetObject("TSBBuscar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBBuscar, "2000")
        Me.TSBBuscar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBBuscar.Name = "TSBBuscar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBBuscar, "2000")
        Me.TSBBuscar.Size = New System.Drawing.Size(65, 22)
        Me.TSBBuscar.Text = "*&Buscar"
        '
        'TSBSiguiente
        '
        Me.TSBSiguiente.ForeColor = System.Drawing.Color.Black
        Me.TSBSiguiente.Image = CType(resources.GetObject("TSBSiguiente.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSiguiente, "2020")
        Me.TSBSiguiente.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSiguiente.Name = "TSBSiguiente"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSiguiente, "2306")
        Me.TSBSiguiente.Size = New System.Drawing.Size(77, 22)
        Me.TSBSiguiente.Text = "*Si&guiente"
        '
        'TSBEscoger
        '
        Me.TSBEscoger.ForeColor = System.Drawing.Color.Black
        Me.TSBEscoger.Image = CType(resources.GetObject("TSBEscoger.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBEscoger, "2002")
        Me.TSBEscoger.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBEscoger.Name = "TSBEscoger"
        Me.COBISResourceProvider.SetResourceID(Me.TSBEscoger, "2002")
        Me.TSBEscoger.Size = New System.Drawing.Size(71, 22)
        Me.TSBEscoger.Text = "*&Escoger"
        '
        'TSBSalir
        '
        Me.TSBSalir.ForeColor = System.Drawing.Color.Black
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "2008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "2008")
        Me.TSBSalir.Size = New System.Drawing.Size(53, 22)
        Me.TSBSalir.Text = "*&Salir"
        '
        'FBusCausalClass
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.TSBotones)
        Me.Controls.Add(Me.PFormas)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.Color.Silver
        Me.Location = New System.Drawing.Point(36, 22)
        Me.Name = "FBusCausalClass"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(531, 334)
        Me.Text = "Listado General de Causales"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.grdCausales, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        Me.PFormas.PerformLayout()
        CType(Me.GBCausales, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GBCausales.ResumeLayout(False)
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializeoptOpcion()
        Me.optOpcion(1) = _optOpcion_1
        Me.optOpcion(0) = _optOpcion_0
    End Sub
    Sub InitializelblTitulo()
        Me.lblTitulo(3) = _lblTitulo_3
        Me.lblTitulo(2) = _lblTitulo_2
        Me.lblTitulo(1) = _lblTitulo_1
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(0) = _cmdBoton_0
        Me.cmdBoton(1) = _cmdBoton_1
        Me.cmdBoton(4) = _cmdBoton_4
        Me.cmdBoton(2) = _cmdBoton_2
        Me.cmdBoton(3) = _cmdBoton_3
    End Sub
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSiguiente As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBEscoger As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Friend WithEvents GBCausales As Infragistics.Win.Misc.UltraGroupBox
#End Region 
End Class


