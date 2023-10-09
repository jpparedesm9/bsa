Imports COBISCorp.tCOBIS.cta.SharedLibrary

<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class FTipoCanjeClass

#Region "Windows Form Designer generated code "
    Public Sub New()
        MyBase.New()
        'This call is required by the Windows Form Designer.
        InitializeComponent()
        InitializetxtCampo()
        InitializelblEtiquetas()
        InitializelblDescripcion()
        InitializecmdBoton()
        InitializeOptcomp()
        InitializeOptcanje()
        'InitializeLine1()
        InitializeFrame4()
        InitializeFrame1()
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
    Public WithEvents grdRegistros As COBISCorp.Framework.UI.Components.COBISGrid
    Private WithEvents _Frame1_0 As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _Optcomp_2 As System.Windows.Forms.RadioButton
    Private WithEvents _Optcomp_0 As System.Windows.Forms.RadioButton
    Private WithEvents _Optcomp_1 As System.Windows.Forms.RadioButton
    Public WithEvents Frame2 As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _Optcanje_3 As System.Windows.Forms.RadioButton
    Private WithEvents _Optcanje_4 As System.Windows.Forms.RadioButton
    Private WithEvents _Optcanje_2 As System.Windows.Forms.RadioButton
    Private WithEvents _Optcanje_1 As System.Windows.Forms.RadioButton
    Private WithEvents _Optcanje_0 As System.Windows.Forms.RadioButton
    Public WithEvents Frame3 As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _txtCampo_0 As System.Windows.Forms.TextBox
    Private WithEvents _lblDescripcion_0 As System.Windows.Forms.Label
    Private WithEvents _lblEtiquetas_0 As System.Windows.Forms.Label
    Private WithEvents _Frame4_0 As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_3 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_4 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_5 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_6 As System.Windows.Forms.Button
    Private WithEvents _lblEtiquetas_1 As System.Windows.Forms.Label
    Public Frame1(0) As Infragistics.Win.Misc.UltraGroupBox
    Public Frame4(0) As Infragistics.Win.Misc.UltraGroupBox
    Public Line1(2) As System.Windows.Forms.Label
    Public Optcanje(4) As System.Windows.Forms.RadioButton
    Public Optcomp(2) As System.Windows.Forms.RadioButton
    Public cmdBoton(6) As System.Windows.Forms.Button
    Public lblDescripcion(0) As System.Windows.Forms.Label
    Public lblEtiquetas(1) As System.Windows.Forms.Label
    Public txtCampo(0) As System.Windows.Forms.TextBox
    Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FTipoCanjeClass))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me._Frame1_0 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.grdRegistros = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me._Frame4_0 = New Infragistics.Win.Misc.UltraGroupBox()
        Me._txtCampo_0 = New System.Windows.Forms.TextBox()
        Me._lblDescripcion_0 = New System.Windows.Forms.Label()
        Me._lblEtiquetas_0 = New System.Windows.Forms.Label()
        Me.Frame2 = New Infragistics.Win.Misc.UltraGroupBox()
        Me._Optcomp_2 = New System.Windows.Forms.RadioButton()
        Me._Optcomp_0 = New System.Windows.Forms.RadioButton()
        Me._Optcomp_1 = New System.Windows.Forms.RadioButton()
        Me.Frame3 = New Infragistics.Win.Misc.UltraGroupBox()
        Me._Optcanje_3 = New System.Windows.Forms.RadioButton()
        Me._Optcanje_4 = New System.Windows.Forms.RadioButton()
        Me._Optcanje_2 = New System.Windows.Forms.RadioButton()
        Me._Optcanje_1 = New System.Windows.Forms.RadioButton()
        Me._Optcanje_0 = New System.Windows.Forms.RadioButton()
        Me._cmdBoton_1 = New System.Windows.Forms.Button()
        Me._cmdBoton_3 = New System.Windows.Forms.Button()
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me._cmdBoton_2 = New System.Windows.Forms.Button()
        Me._cmdBoton_4 = New System.Windows.Forms.Button()
        Me._cmdBoton_5 = New System.Windows.Forms.Button()
        Me._cmdBoton_6 = New System.Windows.Forms.Button()
        Me._lblEtiquetas_1 = New System.Windows.Forms.Label()
        Me.TSBBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSiguientes = New System.Windows.Forms.ToolStripButton()
        Me.TSBIngresar = New System.Windows.Forms.ToolStripButton()
        Me.TSBEliminar = New System.Windows.Forms.ToolStripButton()
        Me.TSBModificar = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.Pformas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me._Frame1_0, System.ComponentModel.ISupportInitialize).BeginInit()
        Me._Frame1_0.SuspendLayout()
        CType(Me.grdRegistros, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me._Frame4_0, System.ComponentModel.ISupportInitialize).BeginInit()
        Me._Frame4_0.SuspendLayout()
        CType(Me.Frame2, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Frame2.SuspendLayout()
        CType(Me.Frame3, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Frame3.SuspendLayout()
        Me.TSBBotones.SuspendLayout()
        CType(Me.Pformas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Pformas.SuspendLayout()
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
        '_Frame1_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Frame1_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._Frame1_0, False)
        Me._Frame1_0.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._Frame1_0.Controls.Add(Me.grdRegistros)
        Me.COBISStyleProvider.SetControlStyle(Me._Frame1_0, "Default")
        Me._Frame1_0.ForeColor = System.Drawing.Color.Navy
        Me._Frame1_0.Location = New System.Drawing.Point(6, 167)
        Me._Frame1_0.Name = "_Frame1_0"
        Me.COBISResourceProvider.SetResourceID(Me._Frame1_0, "502697")
        Me._Frame1_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame1_0.Size = New System.Drawing.Size(545, 228)
        Me._Frame1_0.TabIndex = 12
        Me._Frame1_0.Text = "*Oficinas por tipo de canje"
        Me._Frame1_0.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Frame1_0, "")
        '
        'grdRegistros
        '
        Me.grdRegistros._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdRegistros, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdRegistros, False)
        Me.grdRegistros.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdRegistros.Clip = ""
        Me.grdRegistros.Col = CType(1, Short)
        Me.grdRegistros.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdRegistros.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdRegistros.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdRegistros, "Default")
        Me.grdRegistros.CtlText = ""
        Me.grdRegistros.Dock = System.Windows.Forms.DockStyle.Fill
        Me.COBISStyleProvider.SetEnableStyle(Me.grdRegistros, True)
        Me.grdRegistros.FixedCols = CType(1, Short)
        Me.grdRegistros.FixedRows = CType(1, Short)
        Me.grdRegistros.ForeColor = System.Drawing.Color.Black
        Me.grdRegistros.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdRegistros.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdRegistros.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdRegistros.HighLight = True
        Me.grdRegistros.Location = New System.Drawing.Point(3, 16)
        Me.grdRegistros.Name = "grdRegistros"
        Me.grdRegistros.Picture = Nothing
        Me.grdRegistros.Row = CType(1, Short)
        Me.grdRegistros.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdRegistros.Size = New System.Drawing.Size(539, 209)
        Me.grdRegistros.Sort = CType(2, Short)
        Me.grdRegistros.TabIndex = 13
        Me.grdRegistros.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdRegistros, "")
        '
        '_Frame4_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Frame4_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._Frame4_0, False)
        Me._Frame4_0.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._Frame4_0.Controls.Add(Me._txtCampo_0)
        Me._Frame4_0.Controls.Add(Me._lblDescripcion_0)
        Me._Frame4_0.Controls.Add(Me._lblEtiquetas_0)
        Me.COBISStyleProvider.SetControlStyle(Me._Frame4_0, "Default")
        Me._Frame4_0.ForeColor = System.Drawing.Color.Navy
        Me._Frame4_0.Location = New System.Drawing.Point(6, 5)
        Me._Frame4_0.Name = "_Frame4_0"
        Me._Frame4_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame4_0.Size = New System.Drawing.Size(545, 43)
        Me._Frame4_0.TabIndex = 0
        Me._Frame4_0.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Frame4_0, "")
        '
        '_txtCampo_0
        '
        Me._txtCampo_0.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_0, False)
        Me._txtCampo_0.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_0, "Default")
        Me._txtCampo_0.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_0.Location = New System.Drawing.Point(121, 12)
        Me._txtCampo_0.MaxLength = 5
        Me._txtCampo_0.Name = "_txtCampo_0"
        Me._txtCampo_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_0.Size = New System.Drawing.Size(59, 20)
        Me._txtCampo_0.TabIndex = 1
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_0, "")
        '
        '_lblDescripcion_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_0, False)
        Me._lblDescripcion_0.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_0.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_0, "Default")
        Me._lblDescripcion_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_0.Location = New System.Drawing.Point(181, 12)
        Me._lblDescripcion_0.Name = "_lblDescripcion_0"
        Me._lblDescripcion_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_0.Size = New System.Drawing.Size(349, 20)
        Me._lblDescripcion_0.TabIndex = 99
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_0, "")
        '
        '_lblEtiquetas_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiquetas_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiquetas_0, False)
        Me._lblEtiquetas_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiquetas_0, "Default")
        Me._lblEtiquetas_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiquetas_0.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiquetas_0.Location = New System.Drawing.Point(12, 15)
        Me._lblEtiquetas_0.Name = "_lblEtiquetas_0"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiquetas_0, "502694")
        Me._lblEtiquetas_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiquetas_0.Size = New System.Drawing.Size(104, 14)
        Me._lblEtiquetas_0.TabIndex = 99
        Me._lblEtiquetas_0.Text = "*Codigo de oficina:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiquetas_0, "")
        Me.COBISViewResizer.SetxIncrement(Me._lblEtiquetas_0, False)
        '
        'Frame2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Frame2, False)
        Me.COBISViewResizer.SetAutoResize(Me.Frame2, False)
        Me.Frame2.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.Frame2.Controls.Add(Me._Optcomp_2)
        Me.Frame2.Controls.Add(Me._Optcomp_0)
        Me.Frame2.Controls.Add(Me._Optcomp_1)
        Me.COBISStyleProvider.SetControlStyle(Me.Frame2, "Default")
        Me.Frame2.ForeColor = System.Drawing.Color.Navy
        Me.Frame2.Location = New System.Drawing.Point(6, 110)
        Me.Frame2.Name = "Frame2"
        Me.COBISResourceProvider.SetResourceID(Me.Frame2, "502696")
        Me.Frame2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame2.Size = New System.Drawing.Size(545, 51)
        Me.Frame2.TabIndex = 8
        Me.Frame2.Text = "*Competencia Cormecial"
        Me.Frame2.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Frame2, "")
        '
        '_Optcomp_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Optcomp_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._Optcomp_2, False)
        Me._Optcomp_2.BackColor = System.Drawing.Color.Transparent
        Me._Optcomp_2.Checked = True
        Me.COBISStyleProvider.SetControlStyle(Me._Optcomp_2, "Default")
        Me._Optcomp_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._Optcomp_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Optcomp_2.Location = New System.Drawing.Point(51, 15)
        Me._Optcomp_2.Name = "_Optcomp_2"
        Me.COBISResourceProvider.SetResourceID(Me._Optcomp_2, "502700")
        Me._Optcomp_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Optcomp_2.Size = New System.Drawing.Size(115, 31)
        Me._Optcomp_2.TabIndex = 9
        Me._Optcomp_2.TabStop = True
        Me._Optcomp_2.Text = "*Bancaria"
        Me._Optcomp_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Optcomp_2, "")
        '
        '_Optcomp_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Optcomp_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._Optcomp_0, False)
        Me._Optcomp_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._Optcomp_0, "Default")
        Me._Optcomp_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._Optcomp_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Optcomp_0.Location = New System.Drawing.Point(207, 15)
        Me._Optcomp_0.Name = "_Optcomp_0"
        Me.COBISResourceProvider.SetResourceID(Me._Optcomp_0, "502699")
        Me._Optcomp_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Optcomp_0.Size = New System.Drawing.Size(115, 31)
        Me._Optcomp_0.TabIndex = 10
        Me._Optcomp_0.Text = "*Sin competencia"
        Me._Optcomp_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Optcomp_0, "")
        '
        '_Optcomp_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Optcomp_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._Optcomp_1, False)
        Me._Optcomp_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._Optcomp_1, "Default")
        Me._Optcomp_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._Optcomp_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Optcomp_1.Location = New System.Drawing.Point(379, 15)
        Me._Optcomp_1.Name = "_Optcomp_1"
        Me.COBISResourceProvider.SetResourceID(Me._Optcomp_1, "502698")
        Me._Optcomp_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Optcomp_1.Size = New System.Drawing.Size(115, 31)
        Me._Optcomp_1.TabIndex = 11
        Me._Optcomp_1.Text = "*Con Competencia"
        Me._Optcomp_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Optcomp_1, "")
        '
        'Frame3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Frame3, False)
        Me.COBISViewResizer.SetAutoResize(Me.Frame3, False)
        Me.Frame3.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.Frame3.Controls.Add(Me._Optcanje_3)
        Me.Frame3.Controls.Add(Me._Optcanje_4)
        Me.Frame3.Controls.Add(Me._Optcanje_2)
        Me.Frame3.Controls.Add(Me._Optcanje_1)
        Me.Frame3.Controls.Add(Me._Optcanje_0)
        Me.COBISStyleProvider.SetControlStyle(Me.Frame3, "Default")
        Me.Frame3.ForeColor = System.Drawing.Color.Navy
        Me.Frame3.Location = New System.Drawing.Point(6, 54)
        Me.Frame3.Name = "Frame3"
        Me.COBISResourceProvider.SetResourceID(Me.Frame3, "502695")
        Me.Frame3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame3.Size = New System.Drawing.Size(545, 50)
        Me.Frame3.TabIndex = 2
        Me.Frame3.Text = "*Tipo de Canje"
        Me.Frame3.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Frame3, "")
        '
        '_Optcanje_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Optcanje_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._Optcanje_3, False)
        Me._Optcanje_3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._Optcanje_3, "Default")
        Me._Optcanje_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._Optcanje_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Optcanje_3.Location = New System.Drawing.Point(332, 22)
        Me._Optcanje_3.Name = "_Optcanje_3"
        Me.COBISResourceProvider.SetResourceID(Me._Optcanje_3, "502702")
        Me._Optcanje_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Optcanje_3.Size = New System.Drawing.Size(96, 22)
        Me._Optcanje_3.TabIndex = 6
        Me._Optcanje_3.TabStop = True
        Me._Optcanje_3.Text = "*No CEDEC"
        Me._Optcanje_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Optcanje_3, "")
        '
        '_Optcanje_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Optcanje_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._Optcanje_4, False)
        Me._Optcanje_4.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._Optcanje_4, "Default")
        Me._Optcanje_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._Optcanje_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Optcanje_4.Location = New System.Drawing.Point(438, 22)
        Me._Optcanje_4.Name = "_Optcanje_4"
        Me.COBISResourceProvider.SetResourceID(Me._Optcanje_4, "502701")
        Me._Optcanje_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Optcanje_4.Size = New System.Drawing.Size(96, 22)
        Me._Optcanje_4.TabIndex = 7
        Me._Optcanje_4.TabStop = True
        Me._Optcanje_4.Text = "*Sin CANJE"
        Me._Optcanje_4.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Optcanje_4, "")
        '
        '_Optcanje_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Optcanje_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._Optcanje_2, False)
        Me._Optcanje_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._Optcanje_2, "Default")
        Me._Optcanje_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._Optcanje_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Optcanje_2.Location = New System.Drawing.Point(226, 22)
        Me._Optcanje_2.Name = "_Optcanje_2"
        Me.COBISResourceProvider.SetResourceID(Me._Optcanje_2, "502703")
        Me._Optcanje_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Optcanje_2.Size = New System.Drawing.Size(96, 22)
        Me._Optcanje_2.TabIndex = 5
        Me._Optcanje_2.TabStop = True
        Me._Optcanje_2.Text = "*CEDEC"
        Me._Optcanje_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Optcanje_2, "")
        '
        '_Optcanje_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Optcanje_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._Optcanje_1, False)
        Me._Optcanje_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._Optcanje_1, "Default")
        Me._Optcanje_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._Optcanje_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Optcanje_1.Location = New System.Drawing.Point(117, 22)
        Me._Optcanje_1.Name = "_Optcanje_1"
        Me.COBISResourceProvider.SetResourceID(Me._Optcanje_1, "502704")
        Me._Optcanje_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Optcanje_1.Size = New System.Drawing.Size(104, 22)
        Me._Optcanje_1.TabIndex = 4
        Me._Optcanje_1.TabStop = True
        Me._Optcanje_1.Text = "*Canje delegado"
        Me._Optcanje_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Optcanje_1, "")
        '
        '_Optcanje_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Optcanje_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._Optcanje_0, False)
        Me._Optcanje_0.BackColor = System.Drawing.Color.Transparent
        Me._Optcanje_0.Checked = True
        Me.COBISStyleProvider.SetControlStyle(Me._Optcanje_0, "Default")
        Me._Optcanje_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._Optcanje_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Optcanje_0.Location = New System.Drawing.Point(14, 22)
        Me._Optcanje_0.Name = "_Optcanje_0"
        Me.COBISResourceProvider.SetResourceID(Me._Optcanje_0, "502705")
        Me._Optcanje_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Optcanje_0.Size = New System.Drawing.Size(96, 22)
        Me._Optcanje_0.TabIndex = 3
        Me._Optcanje_0.TabStop = True
        Me._Optcanje_0.Text = "*Canje directo"
        Me._Optcanje_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Optcanje_0, "")
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
        Me._cmdBoton_1.Location = New System.Drawing.Point(-618, 160)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_1, System.Drawing.Color.Silver)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(67, 53)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_1, 1)
        Me._cmdBoton_1.TabIndex = 99
        Me._cmdBoton_1.TabStop = False
        Me._cmdBoton_1.Text = "*&Ingresar"
        Me._cmdBoton_1.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_1, "")
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
        Me._cmdBoton_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_3.Location = New System.Drawing.Point(-618, 303)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_3, System.Drawing.Color.Silver)
        Me._cmdBoton_3.Name = "_cmdBoton_3"
        Me._cmdBoton_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_3.Size = New System.Drawing.Size(67, 53)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_3, 1)
        Me._cmdBoton_3.TabIndex = 99
        Me._cmdBoton_3.TabStop = False
        Me._cmdBoton_3.Text = "*&Limpiar"
        Me._cmdBoton_3.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_3, "")
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
        Me._cmdBoton_0.Location = New System.Drawing.Point(-618, 36)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(67, 53)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 99
        Me._cmdBoton_0.TabStop = False
        Me._cmdBoton_0.Text = "*&Buscar"
        Me._cmdBoton_0.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_0, "")
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
        Me._cmdBoton_2.Location = New System.Drawing.Point(-618, 196)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_2, System.Drawing.Color.Silver)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(67, 53)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_2, 1)
        Me._cmdBoton_2.TabIndex = 99
        Me._cmdBoton_2.TabStop = False
        Me._cmdBoton_2.Text = "*&Eliminar"
        Me._cmdBoton_2.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_2, "")
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
        Me._cmdBoton_4.Location = New System.Drawing.Point(-618, 360)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_4, System.Drawing.Color.Silver)
        Me._cmdBoton_4.Name = "_cmdBoton_4"
        Me._cmdBoton_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_4.Size = New System.Drawing.Size(67, 53)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_4, 1)
        Me._cmdBoton_4.TabIndex = 99
        Me._cmdBoton_4.TabStop = False
        Me._cmdBoton_4.Text = "*&Salir"
        Me._cmdBoton_4.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_4.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_4, "")
        '
        '_cmdBoton_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_5, False)
        Me._cmdBoton_5.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_5, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_5, True)
        Me._cmdBoton_5.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_5, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_5, Nothing)
        Me._cmdBoton_5.Enabled = False
        Me._cmdBoton_5.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_5.Location = New System.Drawing.Point(-618, 95)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_5, System.Drawing.Color.Silver)
        Me._cmdBoton_5.Name = "_cmdBoton_5"
        Me._cmdBoton_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_5.Size = New System.Drawing.Size(67, 53)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_5, 1)
        Me._cmdBoton_5.TabIndex = 99
        Me._cmdBoton_5.TabStop = False
        Me._cmdBoton_5.Text = "*Si&guiente"
        Me._cmdBoton_5.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_5.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_5, "")
        '
        '_cmdBoton_6
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_6, False)
        Me._cmdBoton_6.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_6, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_6, True)
        Me._cmdBoton_6.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_6, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_6, Nothing)
        Me._cmdBoton_6.Enabled = False
        Me._cmdBoton_6.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_6.Location = New System.Drawing.Point(-618, 255)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_6, System.Drawing.Color.Silver)
        Me._cmdBoton_6.Name = "_cmdBoton_6"
        Me._cmdBoton_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_6.Size = New System.Drawing.Size(67, 53)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_6, 1)
        Me._cmdBoton_6.TabIndex = 99
        Me._cmdBoton_6.TabStop = False
        Me._cmdBoton_6.Tag = "8002"
        Me._cmdBoton_6.Text = "*&Modificar"
        Me._cmdBoton_6.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_6.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_6, "")
        '
        '_lblEtiquetas_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiquetas_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiquetas_1, False)
        Me._lblEtiquetas_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiquetas_1, "Default")
        Me._lblEtiquetas_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiquetas_1.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiquetas_1.Location = New System.Drawing.Point(166, 338)
        Me._lblEtiquetas_1.Name = "_lblEtiquetas_1"
        Me._lblEtiquetas_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiquetas_1.Size = New System.Drawing.Size(118, 20)
        Me._lblEtiquetas_1.TabIndex = 99
        Me._lblEtiquetas_1.Text = "Codigo de la oficina:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiquetas_1, "")
        '
        'TSBBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBBotones, "Default")
        Me.TSBBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBuscar, Me.TSBSiguientes, Me.TSBIngresar, Me.TSBEliminar, Me.TSBModificar, Me.TSBLimpiar, Me.TSBSalir})
        Me.TSBBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBBotones.Name = "TSBBotones"
        Me.TSBBotones.Size = New System.Drawing.Size(576, 25)
        Me.TSBBotones.TabIndex = 99
        Me.TSBBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBBotones, "")
        '
        'TSBBuscar
        '
        Me.TSBBuscar.ForeColor = System.Drawing.Color.Black
        Me.TSBBuscar.Image = CType(resources.GetObject("TSBBuscar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBBuscar, "2000")
        Me.TSBBuscar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBBuscar.Name = "TSBBuscar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBBuscar, "2000")
        Me.TSBBuscar.Size = New System.Drawing.Size(67, 22)
        Me.TSBBuscar.Text = "*&Buscar"
        '
        'TSBSiguientes
        '
        Me.TSBSiguientes.ForeColor = System.Drawing.Color.Black
        Me.TSBSiguientes.Image = CType(resources.GetObject("TSBSiguientes.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSiguientes, "2001")
        Me.TSBSiguientes.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSiguientes.Name = "TSBSiguientes"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSiguientes, "2001")
        Me.TSBSiguientes.Size = New System.Drawing.Size(86, 22)
        Me.TSBSiguientes.Text = "*Si&guientes"
        '
        'TSBIngresar
        '
        Me.TSBIngresar.ForeColor = System.Drawing.Color.Black
        Me.TSBIngresar.Image = CType(resources.GetObject("TSBIngresar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBIngresar, "2004")
        Me.TSBIngresar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBIngresar.Name = "TSBIngresar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBIngresar, "2004")
        Me.TSBIngresar.Size = New System.Drawing.Size(74, 22)
        Me.TSBIngresar.Text = "*&Ingresar"
        '
        'TSBEliminar
        '
        Me.TSBEliminar.ForeColor = System.Drawing.Color.Black
        Me.TSBEliminar.Image = CType(resources.GetObject("TSBEliminar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBEliminar, "2006")
        Me.TSBEliminar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBEliminar.Name = "TSBEliminar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBEliminar, "2006")
        Me.TSBEliminar.Size = New System.Drawing.Size(75, 22)
        Me.TSBEliminar.Text = "*&Eliminar"
        '
        'TSBModificar
        '
        Me.TSBModificar.ForeColor = System.Drawing.Color.Black
        Me.TSBModificar.Image = CType(resources.GetObject("TSBModificar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBModificar, "2005")
        Me.TSBModificar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBModificar.Name = "TSBModificar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBModificar, "2005")
        Me.TSBModificar.Size = New System.Drawing.Size(83, 22)
        Me.TSBModificar.Text = "*&Modificar"
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
        'Pformas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Pformas, False)
        Me.COBISViewResizer.SetAutoResize(Me.Pformas, False)
        Me.Pformas.Controls.Add(Me.Frame2)
        Me.Pformas.Controls.Add(Me._Frame1_0)
        Me.Pformas.Controls.Add(Me.Frame3)
        Me.Pformas.Controls.Add(Me._Frame4_0)
        Me.Pformas.Controls.Add(Me._cmdBoton_0)
        Me.Pformas.Controls.Add(Me._cmdBoton_6)
        Me.Pformas.Controls.Add(Me._cmdBoton_3)
        Me.Pformas.Controls.Add(Me._cmdBoton_5)
        Me.Pformas.Controls.Add(Me._cmdBoton_1)
        Me.Pformas.Controls.Add(Me._cmdBoton_4)
        Me.Pformas.Controls.Add(Me._cmdBoton_2)
        Me.Pformas.Controls.Add(Me._lblEtiquetas_1)
        Me.COBISStyleProvider.SetControlStyle(Me.Pformas, "Default")
        Me.Pformas.Location = New System.Drawing.Point(10, 36)
        Me.Pformas.Name = "Pformas"
        Me.Pformas.Size = New System.Drawing.Size(558, 394)
        Me.Pformas.TabIndex = 99
        Me.Pformas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Pformas, "")
        '
        'FTipoCanjeClass
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.AutoScroll = True
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.Pformas)
        Me.Controls.Add(Me.TSBBotones)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.Color.White
        Me.Location = New System.Drawing.Point(-15, 120)
        Me.Name = "FTipoCanjeClass"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(576, 436)
        Me.Tag = "672"
        Me.Text = "Parametrización  por Tipo de canje"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me._Frame1_0, System.ComponentModel.ISupportInitialize).EndInit()
        Me._Frame1_0.ResumeLayout(False)
        CType(Me.grdRegistros, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me._Frame4_0, System.ComponentModel.ISupportInitialize).EndInit()
        Me._Frame4_0.ResumeLayout(False)
        Me._Frame4_0.PerformLayout()
        CType(Me.Frame2, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Frame2.ResumeLayout(False)
        CType(Me.Frame3, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Frame3.ResumeLayout(False)
        Me.TSBBotones.ResumeLayout(False)
        Me.TSBBotones.PerformLayout()
        CType(Me.Pformas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Pformas.ResumeLayout(False)
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializetxtCampo()
        Me.txtCampo(0) = _txtCampo_0
    End Sub
    Sub InitializelblEtiquetas()
        Me.lblEtiquetas(0) = _lblEtiquetas_0
        Me.lblEtiquetas(1) = _lblEtiquetas_1
    End Sub
    Sub InitializelblDescripcion()
        Me.lblDescripcion(0) = _lblDescripcion_0
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(1) = _cmdBoton_1
        Me.cmdBoton(3) = _cmdBoton_3
        Me.cmdBoton(0) = _cmdBoton_0
        Me.cmdBoton(2) = _cmdBoton_2
        Me.cmdBoton(4) = _cmdBoton_4
        Me.cmdBoton(5) = _cmdBoton_5
        Me.cmdBoton(6) = _cmdBoton_6
    End Sub
    Sub InitializeOptcomp()
        Me.Optcomp(2) = _Optcomp_2
        Me.Optcomp(0) = _Optcomp_0
        Me.Optcomp(1) = _Optcomp_1
    End Sub
    Sub InitializeOptcanje()
        Me.Optcanje(3) = _Optcanje_3
        Me.Optcanje(4) = _Optcanje_4
        Me.Optcanje(2) = _Optcanje_2
        Me.Optcanje(1) = _Optcanje_1
        Me.Optcanje(0) = _Optcanje_0
    End Sub
    ' Sub InitializeLine1()
    'Me.Line1(2) = _Line1_2
    'Me.Line1(1) = _Line1_1
    'End Sub
    Sub InitializeFrame4()
        Me.Frame4(0) = _Frame4_0
    End Sub
    Sub InitializeFrame1()
        Me.Frame1(0) = _Frame1_0
    End Sub
    Friend WithEvents Pformas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSiguientes As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBIngresar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBEliminar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBModificar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
#End Region
End Class


