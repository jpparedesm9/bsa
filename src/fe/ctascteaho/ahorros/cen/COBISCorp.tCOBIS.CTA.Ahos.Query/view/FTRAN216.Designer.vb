Imports COBISCorp.tCOBIS.CTA.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class FTran216Class
#Region "Windows Form Designer generated code "
    Public Sub New()
        MyBase.New()
        'This call is required by the Windows Form Designer.
        InitializeComponent()
        InitializeoptVigentes()
        InitializemskValor()
        InitializelblEtiqueta()
        InitializelblDescripcion()
        InitializecmdBoton()
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
    Private WithEvents _mskValor_0 As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _mskValor_1 As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _optVigentes_0 As System.Windows.Forms.RadioButton
    Private WithEvents _optVigentes_1 As System.Windows.Forms.RadioButton
    Public WithEvents frmCriterio As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _cmdBoton_4 As System.Windows.Forms.Button
    Public WithEvents grdValores As COBISCorp.Framework.UI.Components.COBISGrid
    Public WithEvents mskCuenta As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
    Private WithEvents _lblEtiqueta_3 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_5 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_1 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_6 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_0 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_0 As System.Windows.Forms.Label
    Public Line1(2) As System.Windows.Forms.Label
    Public cmdBoton(4) As System.Windows.Forms.Button
    Public lblDescripcion(0) As System.Windows.Forms.Label
    Public lblEtiqueta(6) As System.Windows.Forms.Label
    Public mskValor(1) As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Public optVigentes(1) As System.Windows.Forms.RadioButton
    Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FTran216Class))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me._mskValor_0 = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me._mskValor_1 = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me.frmCriterio = New Infragistics.Win.Misc.UltraGroupBox()
        Me._optVigentes_0 = New System.Windows.Forms.RadioButton()
        Me._optVigentes_1 = New System.Windows.Forms.RadioButton()
        Me._cmdBoton_4 = New System.Windows.Forms.Button()
        Me.grdValores = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me.mskCuenta = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me._cmdBoton_1 = New System.Windows.Forms.Button()
        Me._cmdBoton_2 = New System.Windows.Forms.Button()
        Me._lblEtiqueta_3 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_5 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_1 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_6 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_0 = New System.Windows.Forms.Label()
        Me._lblDescripcion_0 = New System.Windows.Forms.Label()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.GroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBSiguientes = New System.Windows.Forms.ToolStripButton()
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
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GroupBox1.SuspendLayout()
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
        '_mskValor_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._mskValor_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._mskValor_0, False)
        Me.COBISStyleProvider.SetControlStyle(Me._mskValor_0, "Default")
        Me._mskValor_0.Length = CType(64, Short)
        Me._mskValor_0.Location = New System.Drawing.Point(159, 53)
        Me._mskValor_0.Mask = "##/##/####"
        Me._mskValor_0.MaskType = COBISCorp.Framework.UI.Components.ENUM_MASK.[Date]
        Me._mskValor_0.MaxReal = 3.402823E+38!
        Me._mskValor_0.MinReal = -3.402823E+38!
        Me._mskValor_0.Name = "_mskValor_0"
        Me._mskValor_0.Size = New System.Drawing.Size(100, 20)
        Me._mskValor_0.TabIndex = 0
        Me.COBISViewResizer.SetWidthRelativeTo(Me._mskValor_0, "")
        '
        '_mskValor_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._mskValor_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._mskValor_1, False)
        Me.COBISStyleProvider.SetControlStyle(Me._mskValor_1, "Default")
        Me._mskValor_1.Length = CType(64, Short)
        Me._mskValor_1.Location = New System.Drawing.Point(469, 52)
        Me._mskValor_1.Mask = "##/##/####"
        Me._mskValor_1.MaskType = COBISCorp.Framework.UI.Components.ENUM_MASK.[Date]
        Me._mskValor_1.MaxReal = 3.402823E+38!
        Me._mskValor_1.MinReal = -3.402823E+38!
        Me._mskValor_1.Name = "_mskValor_1"
        Me._mskValor_1.Size = New System.Drawing.Size(100, 20)
        Me._mskValor_1.TabIndex = 1
        Me.COBISViewResizer.SetWidthRelativeTo(Me._mskValor_1, "")
        '
        'frmCriterio
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.frmCriterio, False)
        Me.COBISViewResizer.SetAutoResize(Me.frmCriterio, False)
        Me.frmCriterio.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.frmCriterio.Controls.Add(Me._optVigentes_0)
        Me.frmCriterio.Controls.Add(Me._optVigentes_1)
        Me.COBISStyleProvider.SetControlStyle(Me.frmCriterio, "Default")
        Me.frmCriterio.ForeColor = System.Drawing.Color.Navy
        Me.frmCriterio.Location = New System.Drawing.Point(159, 73)
        Me.frmCriterio.Name = "frmCriterio"
        Me.frmCriterio.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.frmCriterio.Size = New System.Drawing.Size(251, 30)
        Me.frmCriterio.TabIndex = 2
        Me.frmCriterio.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.frmCriterio, "")
        '
        '_optVigentes_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optVigentes_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._optVigentes_0, False)
        Me._optVigentes_0.BackColor = System.Drawing.Color.Transparent
        Me._optVigentes_0.Checked = True
        Me.COBISStyleProvider.SetControlStyle(Me._optVigentes_0, "Default")
        Me._optVigentes_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._optVigentes_0.ForeColor = System.Drawing.Color.FromArgb(CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(128, Byte), Integer))
        Me._optVigentes_0.Location = New System.Drawing.Point(7, 6)
        Me._optVigentes_0.Name = "_optVigentes_0"
        Me.COBISResourceProvider.SetResourceID(Me._optVigentes_0, "502022")
        Me._optVigentes_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optVigentes_0.Size = New System.Drawing.Size(108, 17)
        Me._optVigentes_0.TabIndex = 3
        Me._optVigentes_0.TabStop = True
        Me._optVigentes_0.Text = "*Pignoración"
        Me._optVigentes_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optVigentes_0, "")
        '
        '_optVigentes_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optVigentes_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._optVigentes_1, False)
        Me._optVigentes_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optVigentes_1, "Default")
        Me._optVigentes_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._optVigentes_1.ForeColor = System.Drawing.Color.FromArgb(CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(128, Byte), Integer))
        Me._optVigentes_1.Location = New System.Drawing.Point(130, 6)
        Me._optVigentes_1.Name = "_optVigentes_1"
        Me.COBISResourceProvider.SetResourceID(Me._optVigentes_1, "20003")
        Me._optVigentes_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optVigentes_1.Size = New System.Drawing.Size(105, 17)
        Me._optVigentes_1.TabIndex = 4
        Me._optVigentes_1.TabStop = True
        Me._optVigentes_1.Text = "*Liberación"
        Me._optVigentes_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optVigentes_1, "")
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
        Me._cmdBoton_4.Location = New System.Drawing.Point(-100, 128)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_4, System.Drawing.Color.Silver)
        Me._cmdBoton_4.Name = "_cmdBoton_4"
        Me._cmdBoton_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_4.Size = New System.Drawing.Size(59, 51)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_4, 1)
        Me._cmdBoton_4.TabIndex = 99
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
        Me.grdValores.Dock = System.Windows.Forms.DockStyle.Fill
        Me.COBISStyleProvider.SetEnableStyle(Me.grdValores, True)
        Me.grdValores.FixedCols = CType(1, Short)
        Me.grdValores.FixedRows = CType(1, Short)
        Me.grdValores.ForeColor = System.Drawing.Color.Black
        Me.grdValores.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdValores.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdValores.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdValores.HighLight = True
        Me.grdValores.Location = New System.Drawing.Point(3, 16)
        Me.grdValores.Name = "grdValores"
        Me.grdValores.Picture = Nothing
        Me.grdValores.Row = CType(1, Short)
        Me.grdValores.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdValores.Size = New System.Drawing.Size(550, 222)
        Me.grdValores.Sort = CType(2, Short)
        Me.grdValores.TabIndex = 5
        Me.grdValores.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdValores, "")
        '
        'mskCuenta
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskCuenta, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskCuenta, False)
        Me.COBISStyleProvider.SetControlStyle(Me.mskCuenta, "Default")
        Me.mskCuenta.Length = CType(64, Short)
        Me.mskCuenta.Location = New System.Drawing.Point(159, 8)
        Me.mskCuenta.MaxReal = 3.402823E+38!
        Me.mskCuenta.MinReal = -3.402823E+38!
        Me.mskCuenta.Name = "mskCuenta"
        Me.mskCuenta.Size = New System.Drawing.Size(147, 20)
        Me.mskCuenta.TabIndex = 99
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskCuenta, "")
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
        Me._cmdBoton_0.Location = New System.Drawing.Point(-100, 179)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(59, 51)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 99
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
        Me._cmdBoton_1.Location = New System.Drawing.Point(-100, 230)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_1, System.Drawing.Color.Silver)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(59, 51)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_1, 1)
        Me._cmdBoton_1.TabIndex = 99
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
        Me._cmdBoton_2.Location = New System.Drawing.Point(-100, 281)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_2, System.Drawing.Color.Silver)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(59, 51)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_2, 1)
        Me._cmdBoton_2.TabIndex = 99
        Me._cmdBoton_2.TabStop = False
        Me._cmdBoton_2.Text = "*&Salir"
        Me._cmdBoton_2.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_2, "")
        '
        '_lblEtiqueta_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_3, False)
        Me._lblEtiqueta_3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_3, "Default")
        Me._lblEtiqueta_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_3.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_3.Location = New System.Drawing.Point(356, 55)
        Me._lblEtiqueta_3.Name = "_lblEtiqueta_3"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_3, "5173")
        Me._lblEtiqueta_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_3.Size = New System.Drawing.Size(107, 15)
        Me._lblEtiqueta_3.TabIndex = 99
        Me._lblEtiqueta_3.Text = "*Fecha hasta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_3, "")
        '
        '_lblEtiqueta_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_5, False)
        Me._lblEtiqueta_5.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_5, "Default")
        Me._lblEtiqueta_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_5.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_5.Location = New System.Drawing.Point(10, 55)
        Me._lblEtiqueta_5.Name = "_lblEtiqueta_5"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_5, "5172")
        Me._lblEtiqueta_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_5.Size = New System.Drawing.Size(112, 20)
        Me._lblEtiqueta_5.TabIndex = 99
        Me._lblEtiqueta_5.Text = "*Fecha desde:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_5, "")
        '
        '_lblEtiqueta_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_1, False)
        Me._lblEtiqueta_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_1, "Default")
        Me._lblEtiqueta_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_1.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_1.Location = New System.Drawing.Point(10, 82)
        Me._lblEtiqueta_1.Name = "_lblEtiqueta_1"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_1, "5084")
        Me._lblEtiqueta_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_1.Size = New System.Drawing.Size(77, 20)
        Me._lblEtiqueta_1.TabIndex = 99
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
        Me._lblEtiqueta_6.Location = New System.Drawing.Point(10, 32)
        Me._lblEtiqueta_6.Name = "_lblEtiqueta_6"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_6, "500108")
        Me._lblEtiqueta_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_6.Size = New System.Drawing.Size(124, 20)
        Me._lblEtiqueta_6.TabIndex = 99
        Me._lblEtiqueta_6.Text = "*Nombre de la cuenta:"
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
        Me._lblEtiqueta_0.Location = New System.Drawing.Point(10, 10)
        Me._lblEtiqueta_0.Name = "_lblEtiqueta_0"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_0, "501874")
        Me._lblEtiqueta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_0.Size = New System.Drawing.Size(143, 20)
        Me._lblEtiqueta_0.TabIndex = 99
        Me._lblEtiqueta_0.Text = "*No. de cuenta ahorros:"
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
        Me._lblDescripcion_0.Location = New System.Drawing.Point(159, 30)
        Me._lblDescripcion_0.Name = "_lblDescripcion_0"
        Me._lblDescripcion_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_0.Size = New System.Drawing.Size(410, 20)
        Me._lblDescripcion_0.TabIndex = 99
        Me._lblDescripcion_0.UseMnemonic = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_0, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.GroupBox1)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_0)
        Me.PFormas.Controls.Add(Me._mskValor_0)
        Me.PFormas.Controls.Add(Me._lblDescripcion_0)
        Me.PFormas.Controls.Add(Me._mskValor_1)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_6)
        Me.PFormas.Controls.Add(Me.frmCriterio)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_1)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_5)
        Me.PFormas.Controls.Add(Me.mskCuenta)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_3)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(579, 363)
        Me.PFormas.TabIndex = 99
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'GroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupBox1, False)
        Me.GroupBox1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.GroupBox1.Controls.Add(Me.grdValores)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox1, "Default")
        Me.GroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.GroupBox1.Location = New System.Drawing.Point(13, 109)
        Me.GroupBox1.Name = "GroupBox1"
        Me.COBISResourceProvider.SetResourceID(Me.GroupBox1, "501749")
        Me.GroupBox1.Size = New System.Drawing.Size(556, 241)
        Me.GroupBox1.TabIndex = 99
        Me.GroupBox1.Text = "*Valores Bloqueados:"
        Me.GroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox1, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBSiguientes, Me.TSBTransmitir, Me.TSBLimpiar, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(602, 25)
        Me.TSBotones.TabIndex = 99
        Me.TSBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBotones, "")
        '
        'TSBSiguientes
        '
        Me.TSBSiguientes.ForeColor = System.Drawing.SystemColors.ControlText
        Me.TSBSiguientes.Image = CType(resources.GetObject("TSBSiguientes.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSiguientes, "2020")
        Me.TSBSiguientes.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSiguientes.Name = "TSBSiguientes"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSiguientes, "2040")
        Me.TSBSiguientes.Size = New System.Drawing.Size(86, 22)
        Me.TSBSiguientes.Text = "*&Siguientes"
        '
        'TSBTransmitir
        '
        Me.TSBTransmitir.ForeColor = System.Drawing.SystemColors.ControlText
        Me.TSBTransmitir.Image = CType(resources.GetObject("TSBTransmitir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBTransmitir, "2007")
        Me.TSBTransmitir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBTransmitir.Name = "TSBTransmitir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBTransmitir, "2007")
        Me.TSBTransmitir.Size = New System.Drawing.Size(86, 22)
        Me.TSBTransmitir.Text = "*&Transmitir"
        '
        'TSBLimpiar
        '
        Me.TSBLimpiar.ForeColor = System.Drawing.SystemColors.ControlText
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
        Me.TSBSalir.ForeColor = System.Drawing.SystemColors.ControlText
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "2008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "1006")
        Me.TSBSalir.Size = New System.Drawing.Size(54, 22)
        Me.TSBSalir.Text = "*&Salir"
        '
        'FTran216Class
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.AutoScroll = True
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.TSBotones)
        Me.Controls.Add(Me.PFormas)
        Me.Controls.Add(Me._cmdBoton_4)
        Me.Controls.Add(Me._cmdBoton_0)
        Me.Controls.Add(Me._cmdBoton_1)
        Me.Controls.Add(Me._cmdBoton_2)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.Color.White
        Me.Location = New System.Drawing.Point(-3, 123)
        Me.Name = "FTran216Class"
        Me.COBISResourceProvider.SetResourceID(Me, "20006")
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(602, 404)
        Me.Tag = "3022"
        Me.Text = "*Consulta Bloqueo de Valores a la Cuenta de Ahorros"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.frmCriterio, System.ComponentModel.ISupportInitialize).EndInit()
        Me.frmCriterio.ResumeLayout(False)
        CType(Me.grdValores, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        Me.PFormas.PerformLayout()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox1.ResumeLayout(False)
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializeoptVigentes()
        Me.optVigentes(0) = _optVigentes_0
        Me.optVigentes(1) = _optVigentes_1
    End Sub
    Sub InitializemskValor()
        Me.mskValor(0) = _mskValor_0
        Me.mskValor(1) = _mskValor_1
    End Sub
    Sub InitializelblEtiqueta()
        Me.lblEtiqueta(3) = _lblEtiqueta_3
        Me.lblEtiqueta(5) = _lblEtiqueta_5
        Me.lblEtiqueta(1) = _lblEtiqueta_1
        'Me.lblEtiqueta(2) = _lblEtiqueta_2
        Me.lblEtiqueta(6) = _lblEtiqueta_6
        Me.lblEtiqueta(0) = _lblEtiqueta_0
    End Sub
    Sub InitializelblDescripcion()
        Me.lblDescripcion(0) = _lblDescripcion_0
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(4) = _cmdBoton_4
        Me.cmdBoton(0) = _cmdBoton_0
        Me.cmdBoton(1) = _cmdBoton_1
        Me.cmdBoton(2) = _cmdBoton_2
    End Sub

    '  Friend WithEvents Pforma As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBSiguientes As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBTransmitir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Friend WithEvents GroupBox1 As Infragistics.Win.Misc.UltraGroupBox
#End Region
End Class


