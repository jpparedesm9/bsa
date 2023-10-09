<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
 Partial   Class FPUNTOCBClass
#Region "Windows Form Designer generated code "
	Public Sub New()
		MyBase.New()
		isInitializingComponent = True
		InitializeComponent()
		isInitializingComponent = False
		InitializelblEtiqueta()
		InitializecmdBoton()
		InitializeOptPersona()
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
    Public OptPersona(1) As System.Windows.Forms.RadioButton
	Public cmdBoton(5) As System.Windows.Forms.Button
	Public lblEtiqueta(7) As System.Windows.Forms.Label
    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> _
	 Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FPUNTOCBClass))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me._cmdBoton_5 = New System.Windows.Forms.Button()
        Me._cmdBoton_4 = New System.Windows.Forms.Button()
        Me._cmdBoton_2 = New System.Windows.Forms.Button()
        Me._cmdBoton_1 = New System.Windows.Forms.Button()
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me._lblEtiqueta_1 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_2 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_3 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_4 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_5 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_6 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_0 = New System.Windows.Forms.Label()
        Me.lblDescTipoDoc = New System.Windows.Forms.Label()
        Me.lblDepartamento = New System.Windows.Forms.Label()
        Me.lblCiudad = New System.Windows.Forms.Label()
        Me._lblEtiqueta_7 = New System.Windows.Forms.Label()
        Me.lblEstado = New System.Windows.Forms.Label()
        Me.txtNumDoc = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me.grdPuntos = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me.txtCodPunto = New System.Windows.Forms.TextBox()
        Me.txtTipoDoc = New System.Windows.Forms.TextBox()
        Me.txtDepto = New System.Windows.Forms.TextBox()
        Me.txtCiudad = New System.Windows.Forms.TextBox()
        Me.txtDireccion = New System.Windows.Forms.TextBox()
        Me.txtNombre = New System.Windows.Forms.TextBox()
        Me.txtEstado = New System.Windows.Forms.TextBox()
        Me._OptPersona_0 = New System.Windows.Forms.RadioButton()
        Me._OptPersona_1 = New System.Windows.Forms.RadioButton()
        Me.Frame1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.GroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TBSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSiguientes = New System.Windows.Forms.ToolStripButton()
        Me.TBSTransmitir = New System.Windows.Forms.ToolStripButton()
        Me.TBSLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TBSSalir = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        CType(Me.grdPuntos, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.Frame1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Frame1.SuspendLayout()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GroupBox1.SuspendLayout()
        Me.TBSBotones.SuspendLayout()
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
        Me._cmdBoton_5.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_5.Image = CType(resources.GetObject("_cmdBoton_5.Image"), System.Drawing.Image)
        Me._cmdBoton_5.ImageAlign = System.Drawing.ContentAlignment.TopCenter
        Me._cmdBoton_5.Location = New System.Drawing.Point(-586, 328)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_5, System.Drawing.Color.Silver)
        Me._cmdBoton_5.Name = "_cmdBoton_5"
        Me._cmdBoton_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_5.Size = New System.Drawing.Size(61, 55)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_5, 1)
        Me._cmdBoton_5.TabIndex = 14
        Me._cmdBoton_5.Text = "&Salir"
        Me._cmdBoton_5.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_5.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_5.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_5, "")
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
        Me._cmdBoton_4.Location = New System.Drawing.Point(-586, 272)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_4, System.Drawing.Color.Silver)
        Me._cmdBoton_4.Name = "_cmdBoton_4"
        Me._cmdBoton_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_4.Size = New System.Drawing.Size(61, 55)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_4, 1)
        Me._cmdBoton_4.TabIndex = 13
        Me._cmdBoton_4.Text = "&Limpiar"
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
        Me._cmdBoton_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_2.Image = CType(resources.GetObject("_cmdBoton_2.Image"), System.Drawing.Image)
        Me._cmdBoton_2.ImageAlign = System.Drawing.ContentAlignment.TopCenter
        Me._cmdBoton_2.Location = New System.Drawing.Point(-586, 112)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_2, System.Drawing.Color.Silver)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(61, 55)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_2, 1)
        Me._cmdBoton_2.TabIndex = 12
        Me._cmdBoton_2.Text = "&Transmitir"
        Me._cmdBoton_2.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_2.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_2, "")
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
        Me._cmdBoton_1.Enabled = False
        Me._cmdBoton_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_1.Image = CType(resources.GetObject("_cmdBoton_1.Image"), System.Drawing.Image)
        Me._cmdBoton_1.ImageAlign = System.Drawing.ContentAlignment.TopCenter
        Me._cmdBoton_1.Location = New System.Drawing.Point(-586, 56)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_1, System.Drawing.Color.Silver)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(61, 55)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_1, 1)
        Me._cmdBoton_1.TabIndex = 11
        Me._cmdBoton_1.Tag = "388;389"
        Me._cmdBoton_1.Text = "Siguien&te"
        Me._cmdBoton_1.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_1.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_1, "")
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
        Me._cmdBoton_0.Image = CType(resources.GetObject("_cmdBoton_0.Image"), System.Drawing.Image)
        Me._cmdBoton_0.ImageAlign = System.Drawing.ContentAlignment.TopCenter
        Me._cmdBoton_0.Location = New System.Drawing.Point(-586, 0)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(61, 55)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 10
        Me._cmdBoton_0.Tag = "388;389"
        Me._cmdBoton_0.Text = "&Buscar"
        Me._cmdBoton_0.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_0.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_0, "")
        '
        '_lblEtiqueta_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_1, False)
        Me._lblEtiqueta_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_1, "Default")
        Me._lblEtiqueta_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_1.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_1.Location = New System.Drawing.Point(10, 10)
        Me._lblEtiqueta_1.Name = "_lblEtiqueta_1"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_1, "2402")
        Me._lblEtiqueta_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_1.Size = New System.Drawing.Size(110, 20)
        Me._lblEtiqueta_1.TabIndex = 0
        Me._lblEtiqueta_1.Text = "*Cod Punto:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_1, "")
        '
        '_lblEtiqueta_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_2, False)
        Me._lblEtiqueta_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_2, "Default")
        Me._lblEtiqueta_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_2.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_2.Location = New System.Drawing.Point(10, 80)
        Me._lblEtiqueta_2.Name = "_lblEtiqueta_2"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_2, "2403")
        Me._lblEtiqueta_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_2.Size = New System.Drawing.Size(110, 20)
        Me._lblEtiqueta_2.TabIndex = 15
        Me._lblEtiqueta_2.Text = "*Tipo Identificación:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_2, "")
        '
        '_lblEtiqueta_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_3, False)
        Me._lblEtiqueta_3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_3, "Default")
        Me._lblEtiqueta_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_3.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_3.Location = New System.Drawing.Point(10, 103)
        Me._lblEtiqueta_3.Name = "_lblEtiqueta_3"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_3, "2404")
        Me._lblEtiqueta_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_3.Size = New System.Drawing.Size(110, 20)
        Me._lblEtiqueta_3.TabIndex = 16
        Me._lblEtiqueta_3.Text = "*Nro. Identificación:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_3, "")
        '
        '_lblEtiqueta_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_4, False)
        Me._lblEtiqueta_4.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_4, "Default")
        Me._lblEtiqueta_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_4.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_4.Location = New System.Drawing.Point(10, 127)
        Me._lblEtiqueta_4.Name = "_lblEtiqueta_4"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_4, "5036")
        Me._lblEtiqueta_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_4.Size = New System.Drawing.Size(110, 20)
        Me._lblEtiqueta_4.TabIndex = 17
        Me._lblEtiqueta_4.Text = "*Departamento:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_4, "")
        '
        '_lblEtiqueta_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_5, False)
        Me._lblEtiqueta_5.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_5, "Default")
        Me._lblEtiqueta_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_5.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_5.Location = New System.Drawing.Point(10, 151)
        Me._lblEtiqueta_5.Name = "_lblEtiqueta_5"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_5, "501907")
        Me._lblEtiqueta_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_5.Size = New System.Drawing.Size(110, 20)
        Me._lblEtiqueta_5.TabIndex = 18
        Me._lblEtiqueta_5.Text = "*Ciudad:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_5, "")
        '
        '_lblEtiqueta_6
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_6, False)
        Me._lblEtiqueta_6.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_6, "Default")
        Me._lblEtiqueta_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_6.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_6.Location = New System.Drawing.Point(10, 175)
        Me._lblEtiqueta_6.Name = "_lblEtiqueta_6"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_6, "501253")
        Me._lblEtiqueta_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_6.Size = New System.Drawing.Size(110, 20)
        Me._lblEtiqueta_6.TabIndex = 19
        Me._lblEtiqueta_6.Text = "*Dirección:"
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
        Me._lblEtiqueta_0.Location = New System.Drawing.Point(10, 56)
        Me._lblEtiqueta_0.Name = "_lblEtiqueta_0"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_0, "5007")
        Me._lblEtiqueta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_0.Size = New System.Drawing.Size(110, 20)
        Me._lblEtiqueta_0.TabIndex = 20
        Me._lblEtiqueta_0.Text = "*Nombre:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_0, "")
        '
        'lblDescTipoDoc
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblDescTipoDoc, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblDescTipoDoc, False)
        Me.lblDescTipoDoc.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblDescTipoDoc.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblDescTipoDoc, "Default")
        Me.lblDescTipoDoc.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblDescTipoDoc.Location = New System.Drawing.Point(222, 80)
        Me.lblDescTipoDoc.Name = "lblDescTipoDoc"
        Me.lblDescTipoDoc.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblDescTipoDoc.Size = New System.Drawing.Size(352, 20)
        Me.lblDescTipoDoc.TabIndex = 21
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblDescTipoDoc, "")
        '
        'lblDepartamento
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblDepartamento, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblDepartamento, False)
        Me.lblDepartamento.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblDepartamento.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblDepartamento, "Default")
        Me.lblDepartamento.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblDepartamento.Location = New System.Drawing.Point(222, 127)
        Me.lblDepartamento.Name = "lblDepartamento"
        Me.lblDepartamento.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblDepartamento.Size = New System.Drawing.Size(352, 20)
        Me.lblDepartamento.TabIndex = 22
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblDepartamento, "")
        '
        'lblCiudad
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblCiudad, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblCiudad, False)
        Me.lblCiudad.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblCiudad.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblCiudad, "Default")
        Me.lblCiudad.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblCiudad.Location = New System.Drawing.Point(222, 151)
        Me.lblCiudad.Name = "lblCiudad"
        Me.lblCiudad.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblCiudad.Size = New System.Drawing.Size(352, 20)
        Me.lblCiudad.TabIndex = 23
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblCiudad, "")
        '
        '_lblEtiqueta_7
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_7, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_7, False)
        Me._lblEtiqueta_7.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_7, "Default")
        Me._lblEtiqueta_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_7.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_7.Location = New System.Drawing.Point(319, 103)
        Me._lblEtiqueta_7.Name = "_lblEtiqueta_7"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_7, "5067")
        Me._lblEtiqueta_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_7.Size = New System.Drawing.Size(50, 20)
        Me._lblEtiqueta_7.TabIndex = 25
        Me._lblEtiqueta_7.Text = "*Estado:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_7, "")
        '
        'lblEstado
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblEstado, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblEstado, False)
        Me.lblEstado.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblEstado.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblEstado, "Default")
        Me.lblEstado.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblEstado.Location = New System.Drawing.Point(412, 103)
        Me.lblEstado.Name = "lblEstado"
        Me.lblEstado.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblEstado.Size = New System.Drawing.Size(162, 20)
        Me.lblEstado.TabIndex = 26
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblEstado, "")
        '
        'txtNumDoc
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.txtNumDoc, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtNumDoc, False)
        Me.COBISStyleProvider.SetControlStyle(Me.txtNumDoc, "Default")
        Me.txtNumDoc.Length = CType(14, Short)
        Me.txtNumDoc.Location = New System.Drawing.Point(138, 103)
        Me.txtNumDoc.MaxReal = 3.402823E+38!
        Me.txtNumDoc.MinReal = -3.402823E+38!
        Me.txtNumDoc.Name = "txtNumDoc"
        Me.txtNumDoc.Size = New System.Drawing.Size(81, 20)
        Me.txtNumDoc.TabIndex = 3
        Me.txtNumDoc.Tag = "1306"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtNumDoc, "")
        '
        'grdPuntos
        '
        Me.grdPuntos._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdPuntos, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdPuntos, False)
        Me.grdPuntos.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdPuntos.Clip = ""
        Me.grdPuntos.Col = CType(1, Short)
        Me.grdPuntos.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdPuntos.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdPuntos.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdPuntos, "Default")
        Me.grdPuntos.CtlText = ""
        Me.COBISStyleProvider.SetEnableStyle(Me.grdPuntos, True)
        Me.grdPuntos.FixedCols = CType(1, Short)
        Me.grdPuntos.FixedRows = CType(1, Short)
        Me.grdPuntos.ForeColor = System.Drawing.Color.Black
        Me.grdPuntos.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdPuntos.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdPuntos.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdPuntos.HighLight = True
        Me.grdPuntos.Location = New System.Drawing.Point(9, 19)
        Me.grdPuntos.Name = "grdPuntos"
        Me.grdPuntos.Picture = Nothing
        Me.grdPuntos.Row = CType(1, Short)
        Me.grdPuntos.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdPuntos.Size = New System.Drawing.Size(547, 201)
        Me.grdPuntos.Sort = CType(2, Short)
        Me.grdPuntos.TabIndex = 24
        Me.grdPuntos.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdPuntos, "")
        '
        'txtCodPunto
        '
        Me.txtCodPunto.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtCodPunto, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtCodPunto, False)
        Me.txtCodPunto.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtCodPunto, "Default")
        Me.txtCodPunto.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtCodPunto.Location = New System.Drawing.Point(138, 10)
        Me.txtCodPunto.MaxLength = 9
        Me.txtCodPunto.Name = "txtCodPunto"
        Me.txtCodPunto.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtCodPunto.Size = New System.Drawing.Size(81, 20)
        Me.txtCodPunto.TabIndex = 0
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtCodPunto, "")
        '
        'txtTipoDoc
        '
        Me.txtTipoDoc.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtTipoDoc, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtTipoDoc, False)
        Me.txtTipoDoc.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtTipoDoc, "Default")
        Me.txtTipoDoc.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtTipoDoc.Location = New System.Drawing.Point(138, 80)
        Me.txtTipoDoc.MaxLength = 2
        Me.txtTipoDoc.Name = "txtTipoDoc"
        Me.txtTipoDoc.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtTipoDoc.Size = New System.Drawing.Size(81, 20)
        Me.txtTipoDoc.TabIndex = 2
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtTipoDoc, "")
        '
        'txtDepto
        '
        Me.txtDepto.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtDepto, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtDepto, False)
        Me.txtDepto.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtDepto, "Default")
        Me.txtDepto.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtDepto.Location = New System.Drawing.Point(138, 127)
        Me.txtDepto.MaxLength = 5
        Me.txtDepto.Name = "txtDepto"
        Me.txtDepto.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtDepto.Size = New System.Drawing.Size(81, 20)
        Me.txtDepto.TabIndex = 5
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtDepto, "")
        '
        'txtCiudad
        '
        Me.txtCiudad.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtCiudad, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtCiudad, False)
        Me.txtCiudad.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtCiudad, "Default")
        Me.txtCiudad.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtCiudad.Location = New System.Drawing.Point(138, 151)
        Me.txtCiudad.MaxLength = 5
        Me.txtCiudad.Name = "txtCiudad"
        Me.txtCiudad.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtCiudad.Size = New System.Drawing.Size(81, 20)
        Me.txtCiudad.TabIndex = 6
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtCiudad, "")
        '
        'txtDireccion
        '
        Me.txtDireccion.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtDireccion, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtDireccion, False)
        Me.txtDireccion.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtDireccion, "Default")
        Me.txtDireccion.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtDireccion.Location = New System.Drawing.Point(138, 175)
        Me.txtDireccion.MaxLength = 150
        Me.txtDireccion.Name = "txtDireccion"
        Me.txtDireccion.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtDireccion.Size = New System.Drawing.Size(436, 20)
        Me.txtDireccion.TabIndex = 7
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtDireccion, "")
        Me.txtDireccion.WordWrap = False
        '
        'txtNombre
        '
        Me.txtNombre.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtNombre, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtNombre, False)
        Me.txtNombre.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtNombre, "Default")
        Me.txtNombre.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtNombre.Location = New System.Drawing.Point(138, 56)
        Me.txtNombre.MaxLength = 100
        Me.txtNombre.Name = "txtNombre"
        Me.txtNombre.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtNombre.Size = New System.Drawing.Size(436, 20)
        Me.txtNombre.TabIndex = 1
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtNombre, "")
        Me.txtNombre.WordWrap = False
        '
        'txtEstado
        '
        Me.txtEstado.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtEstado, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtEstado, False)
        Me.txtEstado.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtEstado, "Default")
        Me.txtEstado.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtEstado.Location = New System.Drawing.Point(376, 103)
        Me.txtEstado.MaxLength = 10
        Me.txtEstado.Name = "txtEstado"
        Me.txtEstado.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtEstado.Size = New System.Drawing.Size(33, 20)
        Me.txtEstado.TabIndex = 4
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtEstado, "")
        '
        '_OptPersona_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._OptPersona_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._OptPersona_0, False)
        Me._OptPersona_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._OptPersona_0, "Default")
        Me._OptPersona_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._OptPersona_0.ForeColor = System.Drawing.Color.Navy
        Me._OptPersona_0.Location = New System.Drawing.Point(8, 16)
        Me._OptPersona_0.Name = "_OptPersona_0"
        Me.COBISResourceProvider.SetResourceID(Me._OptPersona_0, "2406")
        Me._OptPersona_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._OptPersona_0.Size = New System.Drawing.Size(112, 19)
        Me._OptPersona_0.TabIndex = 28
        Me._OptPersona_0.TabStop = True
        Me._OptPersona_0.Text = "*Persona Natural"
        Me._OptPersona_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._OptPersona_0, "")
        '
        '_OptPersona_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._OptPersona_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._OptPersona_1, False)
        Me._OptPersona_1.BackColor = System.Drawing.Color.Transparent
        Me._OptPersona_1.Checked = True
        Me.COBISStyleProvider.SetControlStyle(Me._OptPersona_1, "Default")
        Me._OptPersona_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._OptPersona_1.ForeColor = System.Drawing.Color.Navy
        Me._OptPersona_1.Location = New System.Drawing.Point(133, 16)
        Me._OptPersona_1.Name = "_OptPersona_1"
        Me.COBISResourceProvider.SetResourceID(Me._OptPersona_1, "2407")
        Me._OptPersona_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._OptPersona_1.Size = New System.Drawing.Size(107, 19)
        Me._OptPersona_1.TabIndex = 2
        Me._OptPersona_1.TabStop = True
        Me._OptPersona_1.Text = "*Persona Juridica"
        Me._OptPersona_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._OptPersona_1, "")
        '
        'Frame1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Frame1, False)
        Me.COBISViewResizer.SetAutoResize(Me.Frame1, False)
        Me.Frame1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.Frame1.Controls.Add(Me._OptPersona_1)
        Me.Frame1.Controls.Add(Me._OptPersona_0)
        Me.COBISStyleProvider.SetControlStyle(Me.Frame1, "Default")
        Me.Frame1.ForeColor = System.Drawing.Color.Navy
        Me.Frame1.Location = New System.Drawing.Point(222, 10)
        Me.Frame1.Name = "Frame1"
        Me.COBISResourceProvider.SetResourceID(Me.Frame1, "2405")
        Me.Frame1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame1.Size = New System.Drawing.Size(352, 41)
        Me.Frame1.TabIndex = 27
        Me.Frame1.Text = "*Tipo de Persona"
        Me.Frame1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Frame1, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.GroupBox1)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_1)
        Me.PFormas.Controls.Add(Me.Frame1)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_2)
        Me.PFormas.Controls.Add(Me.txtEstado)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_3)
        Me.PFormas.Controls.Add(Me.txtNombre)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_4)
        Me.PFormas.Controls.Add(Me.txtDireccion)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_5)
        Me.PFormas.Controls.Add(Me.txtCiudad)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_6)
        Me.PFormas.Controls.Add(Me.txtDepto)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_0)
        Me.PFormas.Controls.Add(Me.txtTipoDoc)
        Me.PFormas.Controls.Add(Me.lblDescTipoDoc)
        Me.PFormas.Controls.Add(Me.txtCodPunto)
        Me.PFormas.Controls.Add(Me.lblDepartamento)
        Me.PFormas.Controls.Add(Me.lblCiudad)
        Me.PFormas.Controls.Add(Me._cmdBoton_0)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_7)
        Me.PFormas.Controls.Add(Me._cmdBoton_1)
        Me.PFormas.Controls.Add(Me.lblEstado)
        Me.PFormas.Controls.Add(Me._cmdBoton_2)
        Me.PFormas.Controls.Add(Me.txtNumDoc)
        Me.PFormas.Controls.Add(Me._cmdBoton_4)
        Me.PFormas.Controls.Add(Me._cmdBoton_5)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(585, 441)
        Me.PFormas.TabIndex = 28
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'GroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupBox1, False)
        Me.GroupBox1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.GroupBox1.Controls.Add(Me.grdPuntos)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox1, "Default")
        Me.GroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.GroupBox1.Location = New System.Drawing.Point(10, 202)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(564, 227)
        Me.GroupBox1.TabIndex = 28
        Me.GroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox1, "")
        '
        'TBSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TBSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TBSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TBSBotones, "Default")
        Me.TBSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBuscar, Me.TSBSiguientes, Me.TBSTransmitir, Me.TBSLimpiar, Me.TBSSalir})
        Me.TBSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TBSBotones.Name = "TBSBotones"
        Me.TBSBotones.Size = New System.Drawing.Size(602, 25)
        Me.TBSBotones.TabIndex = 29
        Me.TBSBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TBSBotones, "")
        '
        'TSBBuscar
        '
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
        Me.TSBSiguientes.Image = CType(resources.GetObject("TSBSiguientes.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSiguientes, "2001")
        Me.TSBSiguientes.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSiguientes.Name = "TSBSiguientes"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSiguientes, "500327")
        Me.TSBSiguientes.Size = New System.Drawing.Size(81, 22)
        Me.TSBSiguientes.Text = "*Siguien&te"
        '
        'TBSTransmitir
        '
        Me.TBSTransmitir.Image = CType(resources.GetObject("TBSTransmitir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TBSTransmitir, "2007")
        Me.TBSTransmitir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TBSTransmitir.Name = "TBSTransmitir"
        Me.COBISResourceProvider.SetResourceID(Me.TBSTransmitir, "2007")
        Me.TBSTransmitir.Size = New System.Drawing.Size(86, 22)
        Me.TBSTransmitir.Text = "*&Transmitir"
        '
        'TBSLimpiar
        '
        Me.TBSLimpiar.Image = CType(resources.GetObject("TBSLimpiar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TBSLimpiar, "2003")
        Me.TBSLimpiar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TBSLimpiar.Name = "TBSLimpiar"
        Me.COBISResourceProvider.SetResourceID(Me.TBSLimpiar, "2003")
        Me.TBSLimpiar.Size = New System.Drawing.Size(72, 22)
        Me.TBSLimpiar.Text = "*&Limpiar"
        '
        'TBSSalir
        '
        Me.TBSSalir.Image = CType(resources.GetObject("TBSSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TBSSalir, "2008")
        Me.TBSSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TBSSalir.Name = "TBSSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TBSSalir, "2008")
        Me.TBSSalir.Size = New System.Drawing.Size(54, 22)
        Me.TBSSalir.Text = "*&Salir"
        '
        'FPUNTOCBClass
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.AutoScroll = True
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.TBSBotones)
        Me.Controls.Add(Me.PFormas)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Location = New System.Drawing.Point(4, 30)
        Me.Name = "FPUNTOCBClass"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(602, 483)
        Me.Text = "Mantenimiento de Puntos de Atención"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.grdPuntos, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.Frame1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Frame1.ResumeLayout(False)
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        Me.PFormas.PerformLayout()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox1.ResumeLayout(False)
        Me.TBSBotones.ResumeLayout(False)
        Me.TBSBotones.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializelblEtiqueta()
        Me.lblEtiqueta(7) = _lblEtiqueta_7
        Me.lblEtiqueta(0) = _lblEtiqueta_0
        Me.lblEtiqueta(6) = _lblEtiqueta_6
        Me.lblEtiqueta(5) = _lblEtiqueta_5
        Me.lblEtiqueta(4) = _lblEtiqueta_4
        Me.lblEtiqueta(3) = _lblEtiqueta_3
        Me.lblEtiqueta(2) = _lblEtiqueta_2
        Me.lblEtiqueta(1) = _lblEtiqueta_1
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(0) = _cmdBoton_0
        Me.cmdBoton(1) = _cmdBoton_1
        Me.cmdBoton(2) = _cmdBoton_2
        Me.cmdBoton(4) = _cmdBoton_4
        Me.cmdBoton(5) = _cmdBoton_5
    End Sub
    Sub InitializeOptPersona()
        Me.OptPersona(1) = _OptPersona_1
        Me.OptPersona(0) = _OptPersona_0
    End Sub
    Private WithEvents commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
    Public WithEvents COBISResourceProvider As COBISCorp.Framework.UI.Components.COBISResourceProvider
    Private WithEvents _lblEtiqueta_1 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_2 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_3 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_4 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_5 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_6 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_0 As System.Windows.Forms.Label
    Public WithEvents ToolTip1 As System.Windows.Forms.ToolTip
    Public WithEvents lblDescTipoDoc As System.Windows.Forms.Label
    Public WithEvents lblDepartamento As System.Windows.Forms.Label
    Public WithEvents lblCiudad As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_7 As System.Windows.Forms.Label
    Public WithEvents lblEstado As System.Windows.Forms.Label
    Public WithEvents txtNumDoc As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _cmdBoton_5 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_4 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
    Public WithEvents grdPuntos As COBISCorp.Framework.UI.Components.COBISGrid
    Public WithEvents txtCodPunto As System.Windows.Forms.TextBox
    Public WithEvents txtTipoDoc As System.Windows.Forms.TextBox
    Public WithEvents txtDepto As System.Windows.Forms.TextBox
    Public WithEvents txtCiudad As System.Windows.Forms.TextBox
    Public WithEvents txtDireccion As System.Windows.Forms.TextBox
    Public WithEvents txtNombre As System.Windows.Forms.TextBox
    Public WithEvents txtEstado As System.Windows.Forms.TextBox
    Private WithEvents _OptPersona_0 As System.Windows.Forms.RadioButton
    Private WithEvents _OptPersona_1 As System.Windows.Forms.RadioButton
    Public WithEvents Frame1 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TBSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSiguientes As System.Windows.Forms.ToolStripButton
    Friend WithEvents TBSTransmitir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TBSLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TBSSalir As System.Windows.Forms.ToolStripButton
    Friend WithEvents GroupBox1 As Infragistics.Win.Misc.UltraGroupBox
#End Region 
End Class


