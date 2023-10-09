Imports COBISCorp.tCOBIS.TADMIN.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
 Partial   Class FTran357Class
#Region "Windows Form Designer generated code "
	Public Sub New()
		MyBase.New()
		isInitializingComponent = True
		InitializeComponent()
		isInitializingComponent = False
		Initializetxtcampo()
		InitializeoptVigentes()
		InitializemskValor()
		InitializelblEtiqueta()
		InitializelblDescripcion()
		InitializecmdBoton()
        'InitializeLine1()
		'This form is an MDI child.
		'This code simulates the Compatibility.VB6 
		' functionality of automatically
		' loading and showing an MDI
		' child's parent.
		'The MDI form in the Compatibility.VB6 project had its
		'AutoShowChildren property set to True
		'To simulate the Compatibility.VB6 behavior, we need to
		'automatically Show the form whenever it
		'is loaded.  If you do not want this behavior
		'then delete the following line of code
		'UPGRADE_TODO: (2018) Remove the next line of code to stop form from automatically showing. More Information: http://www.vbtonet.com/ewis/ewi2018.aspx
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
    Private WithEvents _txtcampo_3 As System.Windows.Forms.TextBox
    Private WithEvents _txtcampo_2 As System.Windows.Forms.TextBox
    Public WithEvents cmdHab As System.Windows.Forms.Button
    Private WithEvents _optVigentes_2 As System.Windows.Forms.RadioButton
    Private WithEvents _optVigentes_1 As System.Windows.Forms.RadioButton
    Private WithEvents _optVigentes_0 As System.Windows.Forms.RadioButton
    Private WithEvents _optVigentes_3 As System.Windows.Forms.RadioButton
    Public WithEvents frmCriterio As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _txtcampo_1 As System.Windows.Forms.TextBox
    Private WithEvents _txtcampo_0 As System.Windows.Forms.TextBox
    Private WithEvents _cmdBoton_4 As System.Windows.Forms.Button
    Public WithEvents grdValores As COBISCorp.Framework.UI.Components.COBISGrid
    Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
    Private WithEvents _mskValor_1 As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _mskValor_0 As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _lblEtiqueta_5 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_3 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_2 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_1 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_4 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_2 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_1 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_6 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_0 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_0 As System.Windows.Forms.Label
    Public Line1(2) As System.Windows.Forms.Label
    Public cmdBoton(4) As System.Windows.Forms.Button
    Public lblDescripcion(2) As System.Windows.Forms.Label
    Public lblEtiqueta(6) As System.Windows.Forms.Label
    Public mskValor(1) As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Public optVigentes(3) As System.Windows.Forms.RadioButton
    Public txtcampo(3) As System.Windows.Forms.TextBox
    Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
     Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FTran357Class))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me._txtcampo_3 = New System.Windows.Forms.TextBox()
        Me._txtcampo_2 = New System.Windows.Forms.TextBox()
        Me.cmdHab = New System.Windows.Forms.Button()
        Me.frmCriterio = New Infragistics.Win.Misc.UltraGroupBox()
        Me._optVigentes_0 = New System.Windows.Forms.RadioButton()
        Me._optVigentes_2 = New System.Windows.Forms.RadioButton()
        Me._optVigentes_1 = New System.Windows.Forms.RadioButton()
        Me._optVigentes_3 = New System.Windows.Forms.RadioButton()
        Me._txtcampo_1 = New System.Windows.Forms.TextBox()
        Me._txtcampo_0 = New System.Windows.Forms.TextBox()
        Me._cmdBoton_4 = New System.Windows.Forms.Button()
        Me.grdValores = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me._cmdBoton_1 = New System.Windows.Forms.Button()
        Me._cmdBoton_2 = New System.Windows.Forms.Button()
        Me._mskValor_1 = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me._mskValor_0 = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me._lblEtiqueta_5 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_3 = New System.Windows.Forms.Label()
        Me._lblDescripcion_2 = New System.Windows.Forms.Label()
        Me._lblDescripcion_1 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_4 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_2 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_1 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_6 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_0 = New System.Windows.Forms.Label()
        Me._lblDescripcion_0 = New System.Windows.Forms.Label()
        Me.GroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBSiguiente = New System.Windows.Forms.ToolStripButton()
        Me.TSBTransmitir = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me.frmCriterio, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.frmCriterio.SuspendLayout()
        CType(Me.grdValores, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GroupBox1.SuspendLayout()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
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
        '_txtcampo_3
        '
        Me._txtcampo_3.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtcampo_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtcampo_3, False)
        Me._txtcampo_3.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtcampo_3, "Default")
        Me._txtcampo_3.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtcampo_3.Location = New System.Drawing.Point(130, 56)
        Me._txtcampo_3.MaxLength = 5
        Me._txtcampo_3.Name = "_txtcampo_3"
        Me._txtcampo_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtcampo_3.Size = New System.Drawing.Size(54, 20)
        Me._txtcampo_3.TabIndex = 3
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtcampo_3, "")
        '
        '_txtcampo_2
        '
        Me._txtcampo_2.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtcampo_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtcampo_2, False)
        Me._txtcampo_2.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtcampo_2, "Default")
        Me._txtcampo_2.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtcampo_2.Location = New System.Drawing.Point(130, 79)
        Me._txtcampo_2.MaxLength = 5
        Me._txtcampo_2.Name = "_txtcampo_2"
        Me._txtcampo_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtcampo_2.Size = New System.Drawing.Size(54, 20)
        Me._txtcampo_2.TabIndex = 4
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtcampo_2, "")
        '
        'cmdHab
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cmdHab, False)
        Me.COBISViewResizer.SetAutoResize(Me.cmdHab, False)
        Me.cmdHab.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me.cmdHab, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me.cmdHab, True)
        Me.cmdHab.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me.cmdHab, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me.cmdHab, Nothing)
        Me.cmdHab.Enabled = False
        Me.cmdHab.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdHab.Location = New System.Drawing.Point(679, 25)
        Me.commandButtonHelper1.SetMaskColor(Me.cmdHab, System.Drawing.Color.Silver)
        Me.cmdHab.Name = "cmdHab"
        Me.cmdHab.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdHab.Size = New System.Drawing.Size(49, 25)
        Me.commandButtonHelper1.SetStyle(Me.cmdHab, 0)
        Me.cmdHab.TabIndex = 20
        Me.cmdHab.Tag = "354"
        Me.cmdHab.Text = "Hab"
        Me.cmdHab.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.cmdHab.UseVisualStyleBackColor = True
        Me.cmdHab.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmdHab, "")
        '
        'frmCriterio
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.frmCriterio, False)
        Me.COBISViewResizer.SetAutoResize(Me.frmCriterio, False)
        Me.frmCriterio.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.frmCriterio.Controls.Add(Me._optVigentes_0)
        Me.frmCriterio.Controls.Add(Me._optVigentes_2)
        Me.frmCriterio.Controls.Add(Me._optVigentes_1)
        Me.frmCriterio.Controls.Add(Me._optVigentes_3)
        Me.COBISStyleProvider.SetControlStyle(Me.frmCriterio, "Default")
        Me.frmCriterio.ForeColor = System.Drawing.Color.Navy
        Me.frmCriterio.Location = New System.Drawing.Point(130, 125)
        Me.frmCriterio.Name = "frmCriterio"
        Me.frmCriterio.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.frmCriterio.Size = New System.Drawing.Size(446, 30)
        Me.frmCriterio.TabIndex = 10
        Me.frmCriterio.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.frmCriterio, "")
        '
        '_optVigentes_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optVigentes_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._optVigentes_0, False)
        Me._optVigentes_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optVigentes_0, "Default")
        Me._optVigentes_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._optVigentes_0.ForeColor = System.Drawing.Color.Navy
        Me._optVigentes_0.Location = New System.Drawing.Point(19, 0)
        Me._optVigentes_0.Name = "_optVigentes_0"
        Me.COBISResourceProvider.SetResourceID(Me._optVigentes_0, "501070")
        Me._optVigentes_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optVigentes_0.Size = New System.Drawing.Size(97, 30)
        Me._optVigentes_0.TabIndex = 6
        Me._optVigentes_0.TabStop = True
        Me._optVigentes_0.Text = "*Solicitadas"
        Me._optVigentes_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optVigentes_0, "")
        '
        '_optVigentes_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optVigentes_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._optVigentes_2, False)
        Me._optVigentes_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optVigentes_2, "Default")
        Me._optVigentes_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._optVigentes_2.ForeColor = System.Drawing.Color.Navy
        Me._optVigentes_2.Location = New System.Drawing.Point(243, 5)
        Me._optVigentes_2.Name = "_optVigentes_2"
        Me.COBISResourceProvider.SetResourceID(Me._optVigentes_2, "501068")
        Me._optVigentes_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optVigentes_2.Size = New System.Drawing.Size(94, 19)
        Me._optVigentes_2.TabIndex = 8
        Me._optVigentes_2.Text = "*Negadas"
        Me._optVigentes_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optVigentes_2, "")
        '
        '_optVigentes_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optVigentes_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._optVigentes_1, False)
        Me._optVigentes_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optVigentes_1, "Default")
        Me._optVigentes_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._optVigentes_1.ForeColor = System.Drawing.Color.Navy
        Me._optVigentes_1.Location = New System.Drawing.Point(131, 2)
        Me._optVigentes_1.Name = "_optVigentes_1"
        Me.COBISResourceProvider.SetResourceID(Me._optVigentes_1, "501069")
        Me._optVigentes_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optVigentes_1.Size = New System.Drawing.Size(93, 27)
        Me._optVigentes_1.TabIndex = 7
        Me._optVigentes_1.Text = "*Aprobadas"
        Me._optVigentes_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optVigentes_1, "")
        '
        '_optVigentes_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optVigentes_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._optVigentes_3, False)
        Me._optVigentes_3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optVigentes_3, "Default")
        Me._optVigentes_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._optVigentes_3.ForeColor = System.Drawing.Color.Navy
        Me._optVigentes_3.Location = New System.Drawing.Point(343, 6)
        Me._optVigentes_3.Name = "_optVigentes_3"
        Me.COBISResourceProvider.SetResourceID(Me._optVigentes_3, "501071")
        Me._optVigentes_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optVigentes_3.Size = New System.Drawing.Size(97, 19)
        Me._optVigentes_3.TabIndex = 9
        Me._optVigentes_3.Text = "*Cta. Abierta"
        Me._optVigentes_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optVigentes_3, "")
        '
        '_txtcampo_1
        '
        Me._txtcampo_1.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtcampo_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtcampo_1, False)
        Me._txtcampo_1.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtcampo_1, "Default")
        Me._txtcampo_1.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtcampo_1.Location = New System.Drawing.Point(130, 102)
        Me._txtcampo_1.MaxLength = 5
        Me._txtcampo_1.Name = "_txtcampo_1"
        Me._txtcampo_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtcampo_1.Size = New System.Drawing.Size(54, 20)
        Me._txtcampo_1.TabIndex = 5
        Me._txtcampo_1.Tag = "371"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtcampo_1, "")
        '
        '_txtcampo_0
        '
        Me._txtcampo_0.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtcampo_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtcampo_0, False)
        Me._txtcampo_0.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtcampo_0, "Default")
        Me._txtcampo_0.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtcampo_0.Location = New System.Drawing.Point(130, 33)
        Me._txtcampo_0.MaxLength = 5
        Me._txtcampo_0.Name = "_txtcampo_0"
        Me._txtcampo_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtcampo_0.Size = New System.Drawing.Size(54, 20)
        Me._txtcampo_0.TabIndex = 2
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtcampo_0, "")
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
        Me._cmdBoton_4.Enabled = False
        Me._cmdBoton_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_4.Location = New System.Drawing.Point(672, 186)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_4, System.Drawing.Color.Silver)
        Me._cmdBoton_4.Name = "_cmdBoton_4"
        Me._cmdBoton_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_4.Size = New System.Drawing.Size(60, 51)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_4, 1)
        Me._cmdBoton_4.TabIndex = 12
        Me._cmdBoton_4.TabStop = False
        Me._cmdBoton_4.Text = "*Siguien&tes"
        Me._cmdBoton_4.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_4.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_4, "")
        '
        'grdValores
        '
        Me.grdValores._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdValores, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdValores, False)
        Me.grdValores.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdValores.Clip = ""
        Me.grdValores.Col = CType(1, Short)
        Me.grdValores.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdValores.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdValores.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdValores, "Default")
        Me.grdValores.CtlText = ""
        Me.COBISStyleProvider.SetEnableStyle(Me.grdValores, True)
        Me.grdValores.FixedCols = CType(1, Short)
        Me.grdValores.FixedRows = CType(1, Short)
        Me.grdValores.ForeColor = System.Drawing.Color.Black
        Me.grdValores.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdValores.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdValores.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdValores.HighLight = True
        Me.grdValores.Location = New System.Drawing.Point(8, 12)
        Me.grdValores.Name = "grdValores"
        Me.grdValores.Picture = Nothing
        Me.grdValores.Row = CType(1, Short)
        Me.grdValores.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdValores.Size = New System.Drawing.Size(556, 249)
        Me.grdValores.Sort = CType(2, Short)
        Me.grdValores.TabIndex = 15
        Me.grdValores.TabStop = False
        Me.grdValores.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdValores, "")
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
        Me._cmdBoton_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_0.Location = New System.Drawing.Point(672, 237)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(60, 51)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 11
        Me._cmdBoton_0.TabStop = False
        Me._cmdBoton_0.Text = "*&Transmitir"
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
        Me._cmdBoton_1.Location = New System.Drawing.Point(672, 289)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_1, System.Drawing.Color.Silver)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(60, 51)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_1, 1)
        Me._cmdBoton_1.TabIndex = 13
        Me._cmdBoton_1.TabStop = False
        Me._cmdBoton_1.Text = "*&Limpiar"
        Me._cmdBoton_1.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_1, "")
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
        Me._cmdBoton_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_2.Location = New System.Drawing.Point(672, 340)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_2, System.Drawing.Color.Silver)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(60, 51)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_2, 1)
        Me._cmdBoton_2.TabIndex = 14
        Me._cmdBoton_2.TabStop = False
        Me._cmdBoton_2.Text = "*&Salir"
        Me._cmdBoton_2.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_2, "")
        '
        '_mskValor_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._mskValor_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._mskValor_1, False)
        Me.COBISStyleProvider.SetControlStyle(Me._mskValor_1, "Default")
        Me._mskValor_1.Length = CType(64, Short)
        Me._mskValor_1.Location = New System.Drawing.Point(386, 10)
        Me._mskValor_1.Mask = "##/##/####"
        Me._mskValor_1.MaskType = COBISCorp.Framework.UI.Components.ENUM_MASK.[Date]
        Me._mskValor_1.MaxReal = 3.402823E+38!
        Me._mskValor_1.MinReal = -3.402823E+38!
        Me._mskValor_1.Name = "_mskValor_1"
        Me._mskValor_1.Size = New System.Drawing.Size(90, 20)
        Me._mskValor_1.TabIndex = 1
        Me.COBISViewResizer.SetWidthRelativeTo(Me._mskValor_1, "")
        '
        '_mskValor_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._mskValor_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._mskValor_0, False)
        Me.COBISStyleProvider.SetControlStyle(Me._mskValor_0, "Default")
        Me._mskValor_0.Length = CType(64, Short)
        Me._mskValor_0.Location = New System.Drawing.Point(130, 10)
        Me._mskValor_0.Mask = "##/##/####"
        Me._mskValor_0.MaskType = COBISCorp.Framework.UI.Components.ENUM_MASK.[Date]
        Me._mskValor_0.MaxReal = 3.402823E+38!
        Me._mskValor_0.MinReal = -3.402823E+38!
        Me._mskValor_0.Name = "_mskValor_0"
        Me._mskValor_0.Size = New System.Drawing.Size(91, 20)
        Me._mskValor_0.TabIndex = 0
        Me.COBISViewResizer.SetWidthRelativeTo(Me._mskValor_0, "")
        '
        '_lblEtiqueta_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_5, False)
        Me._lblEtiqueta_5.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_5, "Default")
        Me._lblEtiqueta_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_5.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_5.Location = New System.Drawing.Point(10, 10)
        Me._lblEtiqueta_5.Name = "_lblEtiqueta_5"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_5, "508568")
        Me._lblEtiqueta_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_5.Size = New System.Drawing.Size(101, 20)
        Me._lblEtiqueta_5.TabIndex = 26
        Me._lblEtiqueta_5.Text = "*Fecha desde:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_5, "")
        '
        '_lblEtiqueta_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_3, False)
        Me._lblEtiqueta_3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_3, "Default")
        Me._lblEtiqueta_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_3.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_3.Location = New System.Drawing.Point(302, 10)
        Me._lblEtiqueta_3.Name = "_lblEtiqueta_3"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_3, "501499")
        Me._lblEtiqueta_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_3.Size = New System.Drawing.Size(87, 20)
        Me._lblEtiqueta_3.TabIndex = 25
        Me._lblEtiqueta_3.Text = "*Fecha hasta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_3, "")
        '
        '_lblDescripcion_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_2, False)
        Me._lblDescripcion_2.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_2.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_2, "Default")
        Me._lblDescripcion_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_2.Location = New System.Drawing.Point(185, 79)
        Me._lblDescripcion_2.Name = "_lblDescripcion_2"
        Me._lblDescripcion_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_2.Size = New System.Drawing.Size(391, 20)
        Me._lblDescripcion_2.TabIndex = 24
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_2, "")
        '
        '_lblDescripcion_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_1, False)
        Me._lblDescripcion_1.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_1, "Default")
        Me._lblDescripcion_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_1.Location = New System.Drawing.Point(185, 56)
        Me._lblDescripcion_1.Name = "_lblDescripcion_1"
        Me._lblDescripcion_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_1.Size = New System.Drawing.Size(391, 20)
        Me._lblDescripcion_1.TabIndex = 23
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_1, "")
        '
        '_lblEtiqueta_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_4, False)
        Me._lblEtiqueta_4.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_4, "Default")
        Me._lblEtiqueta_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_4.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_4.Location = New System.Drawing.Point(10, 56)
        Me._lblEtiqueta_4.Name = "_lblEtiqueta_4"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_4, "508723")
        Me._lblEtiqueta_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_4.Size = New System.Drawing.Size(75, 20)
        Me._lblEtiqueta_4.TabIndex = 22
        Me._lblEtiqueta_4.Text = "*Territorial:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_4, "")
        '
        '_lblEtiqueta_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_2, False)
        Me._lblEtiqueta_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_2, "Default")
        Me._lblEtiqueta_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_2.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_2.Location = New System.Drawing.Point(10, 79)
        Me._lblEtiqueta_2.Name = "_lblEtiqueta_2"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_2, "500873")
        Me._lblEtiqueta_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_2.Size = New System.Drawing.Size(56, 20)
        Me._lblEtiqueta_2.TabIndex = 21
        Me._lblEtiqueta_2.Text = "*Zona:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_2, "")
        '
        '_lblEtiqueta_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_1, False)
        Me._lblEtiqueta_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_1, "Default")
        Me._lblEtiqueta_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_1.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_1.Location = New System.Drawing.Point(10, 125)
        Me._lblEtiqueta_1.Name = "_lblEtiqueta_1"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_1, "5084")
        Me._lblEtiqueta_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_1.Size = New System.Drawing.Size(56, 20)
        Me._lblEtiqueta_1.TabIndex = 19
        Me._lblEtiqueta_1.Text = "*Tipo:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_1, "")
        '
        '_lblEtiqueta_6
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_6, False)
        Me._lblEtiqueta_6.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_6, "Default")
        Me._lblEtiqueta_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_6.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_6.Location = New System.Drawing.Point(10, 102)
        Me._lblEtiqueta_6.Name = "_lblEtiqueta_6"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_6, "500367")
        Me._lblEtiqueta_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_6.Size = New System.Drawing.Size(72, 20)
        Me._lblEtiqueta_6.TabIndex = 18
        Me._lblEtiqueta_6.Text = "*Agencia:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_6, "")
        '
        '_lblEtiqueta_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_0, False)
        Me._lblEtiqueta_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_0, "Default")
        Me._lblEtiqueta_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_0.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_0.Location = New System.Drawing.Point(10, 33)
        Me._lblEtiqueta_0.Name = "_lblEtiqueta_0"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_0, "501072")
        Me._lblEtiqueta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_0.Size = New System.Drawing.Size(113, 20)
        Me._lblEtiqueta_0.TabIndex = 17
        Me._lblEtiqueta_0.Text = "*No. de Solicitud:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_0, "")
        '
        '_lblDescripcion_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_0, False)
        Me._lblDescripcion_0.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_0.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_0, "Default")
        Me._lblDescripcion_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_0.Location = New System.Drawing.Point(185, 102)
        Me._lblDescripcion_0.Name = "_lblDescripcion_0"
        Me._lblDescripcion_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_0.Size = New System.Drawing.Size(391, 20)
        Me._lblDescripcion_0.TabIndex = 16
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_0, "")
        '
        'GroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupBox1, False)
        Me.GroupBox1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.GroupBox1.Controls.Add(Me.grdValores)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox1, "Default")
        Me.GroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.GroupBox1.Location = New System.Drawing.Point(10, 158)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(570, 267)
        Me.GroupBox1.TabIndex = 28
        Me.GroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox1, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me._lblEtiqueta_5)
        Me.PFormas.Controls.Add(Me._lblDescripcion_0)
        Me.PFormas.Controls.Add(Me.cmdHab)
        Me.PFormas.Controls.Add(Me.GroupBox1)
        Me.PFormas.Controls.Add(Me._cmdBoton_4)
        Me.PFormas.Controls.Add(Me._cmdBoton_0)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_0)
        Me.PFormas.Controls.Add(Me._cmdBoton_1)
        Me.PFormas.Controls.Add(Me._txtcampo_3)
        Me.PFormas.Controls.Add(Me._cmdBoton_2)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_6)
        Me.PFormas.Controls.Add(Me._txtcampo_2)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_1)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_2)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_4)
        Me.PFormas.Controls.Add(Me._txtcampo_1)
        Me.PFormas.Controls.Add(Me._lblDescripcion_1)
        Me.PFormas.Controls.Add(Me._txtcampo_0)
        Me.PFormas.Controls.Add(Me._lblDescripcion_2)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_3)
        Me.PFormas.Controls.Add(Me._mskValor_0)
        Me.PFormas.Controls.Add(Me._mskValor_1)
        Me.PFormas.Controls.Add(Me.frmCriterio)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(586, 431)
        Me.PFormas.TabIndex = 30
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBSiguiente, Me.TSBTransmitir, Me.TSBLimpiar, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(604, 25)
        Me.TSBotones.TabIndex = 31
        Me.TSBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBotones, "")
        '
        'TSBSiguiente
        '
        Me.TSBSiguiente.ForeColor = System.Drawing.Color.Black
        Me.TSBSiguiente.Image = CType(resources.GetObject("TSBSiguiente.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSiguiente, "2001")
        Me.TSBSiguiente.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSiguiente.Name = "TSBSiguiente"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSiguiente, "2001")
        Me.TSBSiguiente.Size = New System.Drawing.Size(86, 22)
        Me.TSBSiguiente.Text = "*Siguien&tes"
        '
        'TSBTransmitir
        '
        Me.TSBTransmitir.ForeColor = System.Drawing.Color.Black
        Me.TSBTransmitir.Image = CType(resources.GetObject("TSBTransmitir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBTransmitir, "2000")
        Me.TSBTransmitir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBTransmitir.Name = "TSBTransmitir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBTransmitir, "2000")
        Me.TSBTransmitir.Size = New System.Drawing.Size(67, 22)
        Me.TSBTransmitir.Text = "*&Buscar"
        '
        'TSBLimpiar
        '
        Me.TSBLimpiar.ForeColor = System.Drawing.Color.Black
        Me.TSBLimpiar.Image = CType(resources.GetObject("TSBLimpiar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBLimpiar, "2003")
        Me.TSBLimpiar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBLimpiar.Name = "TSBLimpiar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBLimpiar, "2003")
        Me.TSBLimpiar.Size = New System.Drawing.Size(72, 22)
        Me.TSBLimpiar.Text = "*&Limpiar"
        '
        'TSBSalir
        '
        Me.TSBSalir.ForeColor = System.Drawing.Color.Black
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "2008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "2008")
        Me.TSBSalir.Size = New System.Drawing.Size(54, 22)
        Me.TSBSalir.Text = "*&Salir"
        '
        'FTran357Class
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.AutoScroll = True
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.TSBotones)
        Me.Controls.Add(Me.PFormas)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.Color.White
        Me.Location = New System.Drawing.Point(10, 110)
        Me.Name = "FTran357Class"
        Me.COBISResourceProvider.SetResourceID(Me, "509077")
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(604, 475)
        Me.Tag = "3114"
        Me.Text = "*Consulta de Solicitudes de Apertura Cuenta de Ahorros"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.frmCriterio, System.ComponentModel.ISupportInitialize).EndInit()
        Me.frmCriterio.ResumeLayout(False)
        CType(Me.grdValores, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox1.ResumeLayout(False)
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        Me.PFormas.PerformLayout()
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub Initializetxtcampo()
        Me.txtcampo(3) = _txtcampo_3
        Me.txtcampo(2) = _txtcampo_2
        Me.txtcampo(1) = _txtcampo_1
        Me.txtcampo(0) = _txtcampo_0
    End Sub
    Sub InitializeoptVigentes()
        Me.optVigentes(2) = _optVigentes_2
        Me.optVigentes(1) = _optVigentes_1
        Me.optVigentes(0) = _optVigentes_0
        Me.optVigentes(3) = _optVigentes_3
    End Sub
    Sub InitializemskValor()
        Me.mskValor(1) = _mskValor_1
        Me.mskValor(0) = _mskValor_0
    End Sub
    Sub InitializelblEtiqueta()
        Me.lblEtiqueta(5) = _lblEtiqueta_5
        Me.lblEtiqueta(3) = _lblEtiqueta_3
        Me.lblEtiqueta(4) = _lblEtiqueta_4
        Me.lblEtiqueta(2) = _lblEtiqueta_2
        Me.lblEtiqueta(1) = _lblEtiqueta_1
        Me.lblEtiqueta(6) = _lblEtiqueta_6
        Me.lblEtiqueta(0) = _lblEtiqueta_0
    End Sub
    Sub InitializelblDescripcion()
        Me.lblDescripcion(2) = _lblDescripcion_2
        Me.lblDescripcion(1) = _lblDescripcion_1
        Me.lblDescripcion(0) = _lblDescripcion_0
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(4) = _cmdBoton_4
        Me.cmdBoton(0) = _cmdBoton_0
        Me.cmdBoton(1) = _cmdBoton_1
        Me.cmdBoton(2) = _cmdBoton_2
    End Sub
    'Sub InitializeLine1()
    '    Me.Line1(1) = _Line1_1
    '    Me.Line1(2) = _Line1_2
    '    Me.Line1(0) = _Line1_0
    'End Sub
    Friend WithEvents GroupBox1 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBSiguiente As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBTransmitir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
#End Region
End Class


