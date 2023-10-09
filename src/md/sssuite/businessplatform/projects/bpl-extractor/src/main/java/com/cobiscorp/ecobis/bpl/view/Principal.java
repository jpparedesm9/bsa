package com.cobiscorp.ecobis.bpl.view;

import java.awt.EventQueue;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.swing.ButtonGroup;
import javax.swing.DefaultListModel;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JList;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.JProgressBar;
import javax.swing.JRadioButton;
import javax.swing.JScrollPane;
import javax.swing.JSeparator;
import javax.swing.JTextField;
import javax.swing.border.EmptyBorder;
import javax.swing.filechooser.FileNameExtensionFilter;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.xml.XmlBeanDefinitionReader;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.context.support.GenericApplicationContext;
import org.springframework.core.io.ClassPathResource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.extractor.model.ProcessVersionXml;
import com.cobiscorp.ecobis.bpl.extractor.model.RuleXml;
import com.cobiscorp.ecobis.bpl.extractor.repository.RuleRepository;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Rule;
import com.cobiscorp.ecobis.bpl.service.workflow.ProcessVersionService;
import com.cobiscorp.ecobis.bpl.util.RuleQueryManager;
import com.cobiscorp.ecobis.bpl.util.XmlSerialization;
import com.cobiscorp.ecobis.bpl.util.workflow.ProcessQueryManager;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessVersion;

public class Principal extends JFrame {

	static Logger log = Logger.getLogger(Principal.class);

	private static final long serialVersionUID = 1L;

	// Atributos de la Ventana Principal
	private JPanel contentPane;
	private JTextField txtUsuario;
	private JTextField txtServidor;
	private JTextField txtPuerto;
	private JPasswordField txtClave;
	private JTextField txtXmlSelection;
	private JFileChooser fileChooser;
	private JList listProductsSource;
	private JList listProductsDestination;
	private DefaultListModel modelListProductsSource;
	private DefaultListModel modelListProductsDestination;
	private JRadioButton rdbExport;
	private JRadioButton rdbImport;
	// private JTextField txtServidorAPF;
	// private JTextField txtPuertoAPF;
	private JProgressBar progressBar;
	private JComboBox productsCombo;
	private JButton btnExtraer;
	private JButton btnConsultar;

	// Reglas
	private List<Rule> listRuleSource;
	private List<Rule> listRuleDestination;

	// Workflow
	private List<ProcessVersion> processVersionSourceList;
	private List<ProcessVersion> processVersionDestinationList;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		log.debug("Inicia ejecucion del programa");
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					Principal frame = new Principal();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the frame.
	 */
	public Principal() {
		fileChooser = new JFileChooser();

		// Propiedades Jframe
		setTitle("Migrador de Productos, Procesos y Reglas/Pol\u00edticas");
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 653, 510);
		setResizable(false);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		contentPane.setLayout(null);
		setContentPane(contentPane);

		// Creacion txtUsuario
		txtUsuario = new JTextField();
		txtUsuario.setBounds(77, 103, 164, 20);
		txtUsuario.setColumns(10);
		contentPane.add(txtUsuario);

		// Creacion txtServidor
		txtServidor = new JTextField();
		txtServidor.setColumns(10);
		txtServidor.setBounds(77, 76, 164, 20);
		contentPane.add(txtServidor);

		// Creacion txtPuerto
		txtPuerto = new JTextField();
		txtPuerto.setColumns(10);
		txtPuerto.setBounds(451, 76, 164, 20);
		contentPane.add(txtPuerto);

		// Creacion txtClave
		txtClave = new JPasswordField();
		txtClave.setBounds(451, 103, 164, 20);
		contentPane.add(txtClave);

		// Creacion lblUsuario
		JLabel lblUsuario = new JLabel("Usuario:");
		lblUsuario.setBounds(22, 106, 50, 14);
		contentPane.add(lblUsuario);

		// Creacion lblServidor
		JLabel lblServidor = new JLabel("Servidor:");
		lblServidor.setBounds(21, 79, 60, 14);
		contentPane.add(lblServidor);

		// Creacion lblPuerto
		JLabel lblPuerto = new JLabel("Puerto:");
		lblPuerto.setBounds(394, 79, 50, 14);
		contentPane.add(lblPuerto);

		// Creacion lblClave
		JLabel lblClave = new JLabel("Clave:");
		lblClave.setBounds(394, 106, 46, 14);
		contentPane.add(lblClave);

		// Creacion progressBar
		progressBar = new JProgressBar();
		progressBar.setBounds(80, 409, 538, 14);
		contentPane.add(progressBar);

		// Creacion lblProgreso
		JLabel lblProgreso = new JLabel("Progreso:");
		lblProgreso.setBounds(22, 409, 65, 14);
		contentPane.add(lblProgreso);

		// Creacion btnConsultar
		btnConsultar = new JButton("Consultar");
		btnConsultar.setBounds(241, 445, 89, 23);
		btnConsultar.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				btnConsultar_mouseClicked(e);
			}
		});
		contentPane.add(btnConsultar);

		// Creacion listProductsSource
		listProductsSource = new JList();
		JScrollPane jscroll = new JScrollPane(listProductsSource);
		jscroll.setBounds(22, 215, 262, 171);
		contentPane.add(jscroll);

		// Creacion contentPane
		JLabel lblProductosEnBdd = new JLabel("Productos en BDD:");
		lblProductosEnBdd.setBounds(93, 190, 120, 14);
		contentPane.add(lblProductosEnBdd);

		// Creacion btnAsignar
		JButton btnAsignar = new JButton(">>");
		btnAsignar.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				btnAsignar_mouseClicked(e);
			}
		});
		btnAsignar.setBounds(294, 250, 49, 23);
		contentPane.add(btnAsignar);

		// Creacion btnEliminar
		JButton btnEliminar = new JButton("<<");
		btnEliminar.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				btnEliminar_mouseClicked(e);
			}
		});
		btnEliminar.setBounds(294, 292, 49, 23);
		contentPane.add(btnEliminar);

		// Creacion lblPoductosAExportar
		JLabel lblPoductosAExportar = new JLabel("Productos a Exportar:");
		lblPoductosAExportar.setBounds(428, 190, 130, 14);
		contentPane.add(lblPoductosAExportar);

		// Creacion listProductsDestination
		listProductsDestination = new JList();
		jscroll = new JScrollPane(listProductsDestination);
		jscroll.setBounds(353, 215, 273, 171);
		contentPane.add(jscroll);

		// Creacion lblPathXml
		JLabel lblPathXml = new JLabel("Path Xml:");
		lblPathXml.setBounds(19, 147, 70, 14);
		contentPane.add(lblPathXml);

		// Creacion btnExtraer
		btnExtraer = new JButton("Exportar");
		btnExtraer.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				btnExtraer_mouseClicked(e);
			}
		});
		btnExtraer.setBounds(339, 445, 84, 23);
		contentPane.add(btnExtraer);

		// Creacion txtXmlSelection
		txtXmlSelection = new JTextField();
		txtXmlSelection.setBounds(77, 144, 499, 20);
		contentPane.add(txtXmlSelection);
		txtXmlSelection.setColumns(10);

		// Creacion btnXmlSelection
		JButton btnXmlSelection = new JButton("...");
		btnXmlSelection.setBounds(586, 144, 29, 21);
		btnXmlSelection.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				btnXmlSelection_mouseClicked(e);
			}
		});
		contentPane.add(btnXmlSelection);

		// Creacion separator
		JSeparator separator = new JSeparator();
		separator.setBounds(-1, 134, 638, 2);
		contentPane.add(separator);

		// Creacion separator_1
		JSeparator separator_1 = new JSeparator();
		separator_1.setBounds(-1, 175, 638, 2);
		contentPane.add(separator_1);

		// Creacion label
		JLabel label = new JLabel();
		label.setText("Seleccione producto:");
		label.setBounds(22, 9, 220, 23);
		contentPane.add(label);

		// Creacion productsCombo
		productsCombo = new JComboBox();
		productsCombo.setBounds(22, 33, 218, 23);
		productsCombo.addItem("Procesos");
		productsCombo.addItem("Productos");
		productsCombo.addItem("Reglas/Pol\u00edticas");
		productsCombo.setSelectedIndex(0);
		contentPane.add(productsCombo);

		// Creacion rdbImport
		rdbImport = new JRadioButton("Importar desde Xml");
		rdbImport.setBounds(390, 37, 240, 23);
		rdbImport.addMouseListener(new MouseListener() {

			public void mouseReleased(MouseEvent e) {
				// TODO Auto-generated method stub

			}

			public void mousePressed(MouseEvent e) {
				// TODO Auto-generated method stub

			}

			public void mouseExited(MouseEvent e) {
				// TODO Auto-generated method stub

			}

			public void mouseEntered(MouseEvent e) {
				// TODO Auto-generated method stub

			}

			public void mouseClicked(MouseEvent e) {
				reloadData();
				btnExtraer.setText("Importar");
			}
		});
		contentPane.add(rdbImport);

		// Creacion rdbExport
		rdbExport = new JRadioButton("Exportar a Xml");
		rdbExport.setBounds(390, 11, 220, 23);
		rdbExport.addMouseListener(new MouseListener() {

			public void mouseReleased(MouseEvent e) {
				// TODO Auto-generated method stub

			}

			public void mousePressed(MouseEvent e) {
				// TODO Auto-generated method stub

			}

			public void mouseExited(MouseEvent e) {
				// TODO Auto-generated method stub

			}

			public void mouseEntered(MouseEvent e) {
				// TODO Auto-generated method stub

			}

			public void mouseClicked(MouseEvent e) {
				reloadData();
				btnExtraer.setText("Exportar");

			}
		});
		contentPane.add(rdbExport);

		// Creacion group
		ButtonGroup group = new ButtonGroup();
		group.add(rdbExport);
		group.add(rdbImport);

		// Creacion separator_2
		JSeparator separator_2 = new JSeparator();
		separator_2.setBounds(-1, 67, 638, 2);
		contentPane.add(separator_2);

		// Creacion separator_3
		JSeparator separator_3 = new JSeparator();
		separator_3.setBounds(-1, 397, 638, 2);
		contentPane.add(separator_3);

		// Creacion lblServicioDeAprobacin
		// JLabel lblServicioDeAprobacin = new JLabel("Servidor Aprobaci\u00f3n APF:");
		// lblServicioDeAprobacin.setBounds(22, 411, 150, 14);
		// contentPane.add(lblServicioDeAprobacin);

		// Creacion separator_4
		JSeparator separator_4 = new JSeparator();
		separator_4.setBounds(-1, 432, 638, 2);
		contentPane.add(separator_4);

		// Creacion txtServidorAPF
		// txtServidorAPF = new JTextField();
		// txtServidorAPF.setColumns(10);
		// txtServidorAPF.setBounds(174, 407, 110, 20);
		// contentPane.add(txtServidorAPF);

		// Creacion lblPuertoServidorAprobacion
		// JLabel lblPuertoServidorAprobacion = new JLabel("Puerto Servidor Aprobaci\u00f3n APF:");
		// lblPuertoServidorAprobacion.setBounds(315, 410, 188, 14);
		// contentPane.add(lblPuertoServidorAprobacion);

		// Creacion txtPuertoAPF
		// txtPuertoAPF = new JTextField();
		// txtPuertoAPF.setColumns(10);
		// txtPuertoAPF.setBounds(507, 408, 119, 20);
		// contentPane.add(txtPuertoAPF);

		initData();
	}

	private void btnXmlSelection_mouseClicked(MouseEvent e) {
		this.fileChooser.setFileSelectionMode(JFileChooser.FILES_ONLY);
		this.fileChooser.setFileFilter(new FileNameExtensionFilter("Xml Files", "xml"));
		int returnValue = this.fileChooser.showOpenDialog(this);
		if (returnValue == 0) {
			this.txtXmlSelection.setText(this.fileChooser.getSelectedFile().getPath());
		}
	}

	private void initData() {
		this.txtServidor.setText("127.0.0.1");
		this.txtPuerto.setText("5000");
		this.txtUsuario.setText("sa");
		this.txtClave.setText("");
		this.txtXmlSelection.setText(System.getProperty("user.dir") + File.separator + "archivo.xml");
		this.rdbExport.setSelected(true);
		btnExtraer.setEnabled(false);
	}

	private void reloadData() {
		listRuleSource = new ArrayList<Rule>();
		listRuleDestination = new ArrayList<Rule>();
		processVersionSourceList = new ArrayList<ProcessVersion>();
		processVersionDestinationList = new ArrayList<ProcessVersion>();
		modelListProductsSource = new DefaultListModel();
		modelListProductsDestination = new DefaultListModel();
		listProductsSource.setModel(modelListProductsSource);
		listProductsDestination.setModel(modelListProductsDestination);
		btnExtraer.setEnabled(false);
	}

	/**
	 * Recupera el contexto de la coneccion de la BDD
	 */
	@SuppressWarnings("deprecation")
	private ApplicationContext getContext() {

		// Encuentra el archivo de configuracion de servicios
		GenericApplicationContext context = new GenericApplicationContext();
	    XmlBeanDefinitionReader xmlReader = new XmlBeanDefinitionReader(context);
	    xmlReader.loadBeanDefinitions(new ClassPathResource("META-INF/spring/services-context.xml"));
	 // Recupera el datasourse del archivo
	    DriverManagerDataSource conection = (DriverManagerDataSource)context.getBean("dataSource");
		
	

		// Setea la coneccion con los datos ingresados
		conection.setUrl("jdbc:sqlserver://" + this.txtServidor.getText() + ":" + this.txtPuerto.getText() + ";DatabaseName=cob_pac");
		conection.setUsername(this.txtUsuario.getText());
		conection.setPassword(this.txtClave.getText());
		context.refresh();
		return context;
	}

	/**
	 * Metodo que se llama desde el boton de counltar la informacion
	 */
	private void btnConsultar_mouseClicked(MouseEvent e) {

		int product = productsCombo.getSelectedIndex();

		if (rdbExport.isSelected()) {
			switch (product) {
			case 0:
				queryProcessFromBdd();
				break;
			case 1:
				queryProductFromBdd();
				break;
			case 2:
				queryRuleFromBdd();
				break;

			default:
				break;
			}
		}

		if (rdbImport.isSelected()) {
			switch (product) {
			case 0:
				queryProcessFromXml();
				break;

			case 1:
				queryProductFromXml();
				break;

			case 2:
				queryRuleFromXml();
				break;

			default:
				break;
			}
		}
	}

	/**
	 * Metodo que se ejcuta al momento de lanzar el envento clis del boton asignar
	 */
	private void btnAsignar_mouseClicked(MouseEvent e) {
		int count = 0;
		if (productsCombo.getSelectedIndex() == 0) {

			for (int i : listProductsSource.getSelectedIndices()) {
				modelListProductsDestination.addElement(modelListProductsSource.get(i - count));
				processVersionDestinationList.add(processVersionSourceList.get(i - count));
				modelListProductsSource.remove(i - count);
				processVersionSourceList.remove(i - count);
				count++;
			}

			if (!processVersionDestinationList.isEmpty()) {
				btnExtraer.setEnabled(true);
			}

		} else if (productsCombo.getSelectedIndex() == 1) {

		} else if (productsCombo.getSelectedIndex() == 2) {

			for (int i : listProductsSource.getSelectedIndices()) {
				modelListProductsDestination.addElement(modelListProductsSource.get(i - count));
				listRuleDestination.add(listRuleSource.get(i - count));
				modelListProductsSource.remove(i - count);
				listRuleSource.remove(i - count);
				count++;
			}

			if (!listRuleDestination.isEmpty()) {
				btnExtraer.setEnabled(true);
			}
		}
	}

	/**
	 * Metodo que se ejcuta al momento de lanzar el envento clis del boton desasignar
	 */
	private void btnEliminar_mouseClicked(MouseEvent e) {
		int count = 0;
		if (rdbExport.isSelected() || rdbImport.isSelected()) {
			for (int i : listProductsDestination.getSelectedIndices()) {
				modelListProductsSource.addElement(modelListProductsDestination.get(i - count));
				modelListProductsDestination.remove(i - count);
				count++;
			}
		} else {
			for (int i : listProductsDestination.getSelectedIndices()) {
				modelListProductsSource.addElement(modelListProductsDestination.get(i - count));
				listRuleSource.add(listRuleDestination.get(i - count));
				listRuleDestination.remove(i - count);
				modelListProductsDestination.remove(i - count);
				count++;
			}
		}
	}

	/**
	 * Metodo para extraer o importar la informacion desde la base a XML
	 */
	private void btnExtraer_mouseClicked(MouseEvent e) {

		int product = productsCombo.getSelectedIndex();
		if (rdbImport.isSelected()) {

			switch (product) {
			case 0:
				saveProcessToBdd();
				break;
			case 1:
				saveProductToBdd();
				break;
			case 2:
				saveRuleToBdd();
				break;

			default:
				break;
			}

		} else if (rdbExport.isSelected()) {

			switch (product) {
			case 0:
				saveProcessToXML();
				break;
			case 1:
				saveProductToXML();
				break;
			case 2:
				saveRuleToXml();
				break;
			default:
				break;
			}

		}
	}

	/**
	 * Metodo que recupera los procesos para llenar el listado de procesos de la ventana a ser exportados a XML
	 */
	private void queryProcessFromBdd() {
		try {

			// Recupero el contexto y el servicio de la version de process version
			ProcessVersionService processVersionService = getContext().getBean(ProcessVersionService.class);
			List<ProcessVersion> processVersionList = processVersionService.findProductionProcessVersion();

			// Instancio DefaultListModel para el listado origen y destino
			modelListProductsSource = new DefaultListModel();
			modelListProductsDestination = new DefaultListModel();

			// Inicializo las listas de procesos tanto de origen como destino
			processVersionSourceList = new ArrayList<ProcessVersion>();
			processVersionDestinationList = new ArrayList<ProcessVersion>();

			// Recorro la lista de versiones procesos
			for (ProcessVersion processVersion : processVersionList) {
				// Se llena el DefaultListModel

				modelListProductsSource.addElement(processVersion.getVersionProcess() + " - " + processVersion.getProcess().getName());
				// Se llena la lista de Procesos de origen
				processVersionSourceList.add(processVersion);
			}

			// Seteo los modelos a los componentes de la ventana
			listProductsSource.setModel(modelListProductsSource);
			listProductsDestination.setModel(modelListProductsDestination);

			// Lanzo mensaje
			JOptionPane.showMessageDialog(this, "La informaci\u00f3n se proceso con \u00e9xito", "Proceso exitoso", JOptionPane.INFORMATION_MESSAGE);

		} catch (Exception ex) {
			reloadData();
			Object[] options = { "Ok", "Ver Log" };
			int retorno = JOptionPane.showOptionDialog(this,
					"Ocurrio un problema al procesar la informaci\u00f3n Para mayor informaci\u00f3n revisar el log",
					"Problemas al procesar la informaci\u00f3n", JOptionPane.DEFAULT_OPTION, JOptionPane.ERROR_MESSAGE, null, options, "Ok");
			if (retorno == 1) {
				try {
					Runtime.getRuntime().exec("notepad logingFile.log");
				} catch (IOException e) {
					log.error("Error al grabar el producto", e);
				}
			}

			log.error("Error al grabar el producto", ex);
		}

	}

	/**
	 * Metodo que recupera los productos apf para llenar el listado de productos apf de la ventana a ser exportados a XML
	 */
	private void queryProductFromBdd() {
		try {

		} catch (Exception ex) {
			reloadData();
			Object[] options = { "Ok", "Ver Log" };
			int retorno = JOptionPane.showOptionDialog(this,
					"Ocurrio un problema al procesar la informaci\u00f3n Para mayor informaci\u00f3n revisar el log",
					"Problemas al procesar la informaci\u00f3n", JOptionPane.DEFAULT_OPTION, JOptionPane.ERROR_MESSAGE, null, options, "Ok");
			if (retorno == 1) {
				try {
					Runtime.getRuntime().exec("notepad logingFile.log");
				} catch (IOException e) {
					log.error("Error al grabar el producto", e);
				}
			}

			log.error("Error al grabar el producto", ex);
		}

	}

	/**
	 * Metodo que recupera las reglas para llenar el listado de reglas de la ventana a ser exportados a XML
	 */
	private void queryRuleFromBdd() {
		try {

			reloadData();
			// Recupero el contexto y el servicio de la version de process version
			RuleRepository repo = getContext().getBean(RuleRepository.class);
			List<Rule> temp = repo.findProductionRules();

			// Instancio DefaultListModel para el listado origen y destino
			modelListProductsSource = new DefaultListModel();
			modelListProductsDestination = new DefaultListModel();

			// Inicializo las listas de procesos tanto de origen como destino
			listRuleSource = new ArrayList<Rule>();
			listRuleDestination = new ArrayList<Rule>();

			// Recorro la lista de reglas
			for (Rule prd : temp) {
				// Se llena el DefaultListModel
				modelListProductsSource.addElement(prd.getId() + " -" + prd.getName());
				// Se llena la lista de Procesos de origen
				listRuleSource.add(prd);
			}

			// Seteo los modelos a los componentes de la ventana
			listProductsSource.setModel(modelListProductsSource);
			listProductsDestination.setModel(modelListProductsDestination);

			// Lanzo mensaje
			JOptionPane.showMessageDialog(this, "La informaci\u00f3n se proceso con \u00e9xito", "Proceso exitoso", JOptionPane.INFORMATION_MESSAGE);

		} catch (Exception ex) {
			reloadData();
			Object[] options = { "Ok", "Ver Log" };
			int retorno = JOptionPane.showOptionDialog(this,
					"Ocurrio un problema al procesar la informaci\u00f3n Para mayor informaci\u00f3n revisar el log",
					"Problemas al procesar la informaci\u00f3n", JOptionPane.DEFAULT_OPTION, JOptionPane.ERROR_MESSAGE, null, options, "Ok");
			if (retorno == 1) {
				try {
					Runtime.getRuntime().exec("notepad logingFile.log");
				} catch (IOException e) {
					log.error("Error al grabar el producto", e);
				}
			}

			log.error("Error al grabar el producto", ex);
		}
	}

	/**
	 * Metodo guarda la informacion apf recuperada de la dbb en xml
	 */
	private void saveProductToXML() {

	}

	/**
	 * Metodo guarda la informacion process recuperada de la dbb en xml
	 */
	private void saveProcessToXML() {

		XmlSerialization<ProcessVersionXml> serializer = new XmlSerialization<ProcessVersionXml>();
		try {

			// Recuperar toda la informcaion desde un servisio
			List<ProcessVersion> proccesVersionList = ProcessQueryManager.prepareListToXml(processVersionDestinationList, getContext());

			// Intsancio el processXML
			ProcessVersionXml processVersionXml = new ProcessVersionXml();
			processVersionXml.setProcessVersionList(proccesVersionList);

			// Serailizo la lista de procesos
			serializer.serialization(txtXmlSelection.getText(), processVersionXml);

			// Lanzo mensaje
			JOptionPane.showMessageDialog(this, "La informaci\u00f3n se proceso con \u00e9xito", "Proceso exitoso", JOptionPane.INFORMATION_MESSAGE);
		} catch (Exception ex) {
			reloadData();
			Object[] options = { "Ok", "Ver Log" };
			int retorno = JOptionPane.showOptionDialog(this,
					"Ocurrio un problema al procesar la informaci\u00f3n Para mayor informaci\u00f3n revisar el log",
					"Problemas al procesar la informaci\u00f3n", JOptionPane.DEFAULT_OPTION, JOptionPane.ERROR_MESSAGE, null, options, "Ok");
			if (retorno == 1) {
				try {
					Runtime.getRuntime().exec("notepad logingFile.log");
				} catch (IOException e) {
					log.error("Error al grabar el producto", e);
				}
			}

			log.error("Error al grabar el producto", ex);
		}

	}

	/**
	 * Metodo guarda la informacion reglas recuperada de la dbb en xml
	 */
	private void saveRuleToXml() {
		XmlSerialization<RuleXml> serializer = new XmlSerialization<RuleXml>();
		try {
			log.info("Se inicia a grabar la(s) regla(s) al Xml");
			RuleXml bp = new RuleXml();
			log.info("Llama al m�todo que se encarga de preparas la informacion de la(s) regla(s)");
			bp.setRules(RuleQueryManager.prepareListToXml(listRuleDestination, getContext()));
			log.info("Finaliza el metodo que se encarga de preparas la informacion de la(s) regla(s)");
			log.info("Inicia la serializaci�n");
			serializer.serialization(txtXmlSelection.getText(), bp);
			log.info("Se grabo exitosamente el Xml");
			JOptionPane.showMessageDialog(this, "La informaci\u00f3n se proceso con \u00e9xito", "Proceso exitoso", JOptionPane.INFORMATION_MESSAGE);
		} catch (Exception ex) {
			reloadData();
			Object[] options = { "Ok", "Ver Log" };
			int retorno = JOptionPane.showOptionDialog(this,
					"Ocurrio un problema al procesar la informaci\u00f3n. Para mayor informaci\u00f3n revisar el log",
					"Problemas al procesar la informaci\u00f3n", JOptionPane.DEFAULT_OPTION, JOptionPane.ERROR_MESSAGE, null, options, "Ok");
			if (retorno == 1) {
				try {
					Runtime.getRuntime().exec("notepad logingFile.log");
				} catch (IOException e) {
					log.error("Error al grabar el producto", e);
				}
			}

			log.error("Error al grabar el producto", ex);
		}
	}

	/**
	 * Metodo que deseraliza la informacion de xml a objetos
	 */
	private void queryProcessFromXml() {
		XmlSerialization<ProcessVersionXml> serializer = new XmlSerialization<ProcessVersionXml>();
		try {

			// Deserealizo el XML
			ProcessVersionXml processVersionXml = serializer.deserialization(txtXmlSelection.getText(), new ProcessVersionXml());

			// Recuperar toda la informcaion desde de los procesos desde los xml
			List<ProcessVersion> processVersionList = processVersionXml.getProcessVersionList();

			// Instancio DefaultListModel para el listado origen y destino
			modelListProductsSource = new DefaultListModel();
			modelListProductsDestination = new DefaultListModel();

			// Inicializo las listas de procesos tanto de origen como destino
			processVersionSourceList = new ArrayList<ProcessVersion>();
			processVersionDestinationList = new ArrayList<ProcessVersion>();

			// Recorro la lista de versiones procesos
			for (ProcessVersion processVersion : processVersionList) {
				// Se llena el DefaultListModel
				modelListProductsSource.addElement(processVersion.getIdProcessVersion().getVersionProcess() + " - "
						+ processVersion.getProcess().getName());
				// Se llena la lista de Procesos de origen
				processVersionSourceList.add(processVersion);
			}

			// Seteo los modelos a los componentes de la ventana
			listProductsSource.setModel(modelListProductsSource);
			listProductsDestination.setModel(modelListProductsDestination);

			JOptionPane.showMessageDialog(this, "La informaci\u00f3n se proceso con \u00e9xito", "Proceso exitoso", JOptionPane.INFORMATION_MESSAGE);
		} catch (Exception ex) {
			reloadData();
			Object[] options = { "Ok", "Ver Log" };
			int retorno = JOptionPane.showOptionDialog(this,
					"Ocurrio un problema al procesar la informaci\u00f3n. Para mayor informaci\u00f3n revisar el log",
					"Problemas al procesar la informaci\u00f3n", JOptionPane.DEFAULT_OPTION, JOptionPane.ERROR_MESSAGE, null, options, "Ok");
			if (retorno == 1) {
				try {
					Runtime.getRuntime().exec("notepad logingFile.log");
				} catch (IOException e) {
					log.error("Error al grabar el producto", e);
				}
			}

			log.error("Error al grabar el producto", ex);
		}
	}

	/**
	 * Metodo que deseraliza la informacion de xml a objetos
	 */
	private void queryProductFromXml() {

	}

	/**
	 * Metodo que deseraliza la informacion de xml a objetos
	 */
	private void queryRuleFromXml() {
		XmlSerialization<RuleXml> serializer = new XmlSerialization<RuleXml>();
		try {
			reloadData();
			RuleXml bp = serializer.deserialization(txtXmlSelection.getText(), new RuleXml());
			List<Rule> temp = bp.getRules();
			modelListProductsSource = new DefaultListModel();
			listRuleSource = new ArrayList<Rule>();
			for (Rule prd : temp) {
				modelListProductsSource.addElement(prd.getId() + " -" + prd.getName());
				listRuleSource.add(prd);
			}
			listProductsSource.setModel(modelListProductsSource);

			modelListProductsDestination = new DefaultListModel();
			listRuleDestination = new ArrayList<Rule>();
			listProductsDestination.setModel(modelListProductsDestination);
			JOptionPane.showMessageDialog(this, "La informaci\u00f3n se proceso con \u00e9xito", "Proceso exitoso", JOptionPane.INFORMATION_MESSAGE);
		} catch (Exception ex) {
			reloadData();
			Object[] options = { "Ok", "Ver Log" };
			int retorno = JOptionPane.showOptionDialog(this,
					"Ocurrio un problema al procesar la informaci\u00f3n Para mayor informaci\u00f3n revisar el log",
					"Problemas al procesar la informaci\u00f3n", JOptionPane.DEFAULT_OPTION, JOptionPane.ERROR_MESSAGE, null, options, "Ok");
			if (retorno == 1) {
				try {
					Runtime.getRuntime().exec("notepad logingFile.log");
				} catch (IOException e) {
					log.error("Error al grabar el producto", e);
				}
			}

			log.error("Error al grabar el producto", ex);
		}
	}

	/**
	 * Metodo guarda la informacion de productos en BDD lo generado en el XML
	 */
	private void saveProductToBdd() {

	}

	/**
	 * Metodo guarda la informacion de procesos en BDD lo generado en el XML
	 */
	@SuppressWarnings("static-access")
	private void saveProcessToBdd() {

		Object[] options = { "Aceptar", "Cancelar" };
		JOptionPane jpJOptionPane = new JOptionPane();
		int retorno = jpJOptionPane.showOptionDialog(this, "Este proceso eliminara las versiones en construcci\u00f3n de los procesos seleccionados",
				"Advertencia", JOptionPane.WARNING_MESSAGE, JOptionPane.WARNING_MESSAGE, null, options, null);

		JdbcTemplate jt = new JdbcTemplate((DriverManagerDataSource) getContext().getBean("dataSource"));
		
		if (retorno == 0) {

			try {
				

//				jt.execute("cobis..sp_procxmode sp_ad_obtiene_cultura_defecto , 'anymode'");
//				jt.execute("cobis..sp_procxmode sp_cseqnos, 'anymode'");
				
				ProcessQueryManager.deleteProcessVersion(processVersionDestinationList, getContext(),
						(DriverManagerDataSource) getContext().getBean("dataSource"));
				

				JOptionPane.showOptionDialog(this, "Versiones en construcci\u00f3n eliminadas con \u00e9xito", "Informaci\u00f3n",
						JOptionPane.INFORMATION_MESSAGE, JOptionPane.INFORMATION_MESSAGE, null, new Object[] { "OK" }, null);

				jpJOptionPane = new JOptionPane();
				retorno = jpJOptionPane.showOptionDialog(this, "Se generaran las nuevas versiones para los procesos seleccionados",
						"Informaci\u00f3n", JOptionPane.INFORMATION_MESSAGE, JOptionPane.INFORMATION_MESSAGE, null, options, null);

				if (retorno == 0) {

					ProcessQueryManager.saveListToBdd(processVersionDestinationList, getContext(),
							(DriverManagerDataSource) getContext().getBean("dataSource"));

					JOptionPane.showMessageDialog(this, "La informaci\u00f3n se proceso con \u00e9xito", "Proceso exitoso",
							JOptionPane.INFORMATION_MESSAGE);
					
//					jt.execute("cobis..sp_procxmode sp_ad_obtiene_cultura_defecto , 'Unchained'");
//					jt.execute("cobis..sp_procxmode sp_cseqnos, 'Unchained'");

					reloadData();

				} else {
					jpJOptionPane.getRootFrame().dispose();
//					jt.execute("cobis..sp_procxmode sp_ad_obtiene_cultura_defecto , 'Unchained'");
//					jt.execute("cobis..sp_procxmode sp_cseqnos, 'Unchained'");
				}

			} catch (Exception ex) {
//				jt.execute("cobis..sp_procxmode sp_ad_obtiene_cultura_defecto , 'Unchained'");
//				jt.execute("cobis..sp_procxmode sp_cseqnos, 'Unchained'");
				reloadData();
				Object[] optionsException = { "Ok", "Ver Log" };
				int retornoException = JOptionPane.showOptionDialog(this,
						"Ocurrio un problema al procesar la informaci\u00f3n Para mayor informaci\u00f3n revisar el log",
						"Problemas al procesar la informaci\u00f3n", JOptionPane.DEFAULT_OPTION, JOptionPane.ERROR_MESSAGE, null, optionsException,
						"Ok");
				if (retornoException == 1) {
					try {
						Runtime.getRuntime().exec("notepad logingFile.log");
					} catch (IOException e) {
						log.error("Error al grabar el producto", e);
					}
				}
				log.error("Error al grabar el producto", ex);
			}

		} else {
			jpJOptionPane.getRootFrame().dispose();
		}

	}

	/**
	 * Metodo guarda la informacion de reglas en BDD lo generado en el XML
	 */
	private void saveRuleToBdd() {
		try {
			boolean execute = false;
			String messageValidation = RuleQueryManager.validateRule(listRuleDestination, getContext());
			execute = (null == messageValidation || "".equals(messageValidation.trim()));
			if (!execute) {
				execute = JOptionPane.YES_OPTION == JOptionPane.showConfirmDialog(this, messageValidation);
			}
			if (execute) {
				RuleQueryManager.saveListToBdd(listRuleDestination, getContext(), (DriverManagerDataSource) getContext().getBean("dataSource"));
			}
			JOptionPane.showMessageDialog(this, "La informaci\u00f3n se proceso con \u00e9xito", "Proceso exitoso", JOptionPane.INFORMATION_MESSAGE);

			reloadData();

		} catch (Exception ex) {
			reloadData();
			ex.printStackTrace();
			Object[] options = { "Ok", "Ver Log" };
			int retorno = JOptionPane.showOptionDialog(this,
					"Ocurrio un problema al procesar la informaci\u00f3n Para mayor informaci\u00f3n revisar el log",
					"Problemas al procesar la informaci\u00f3n", JOptionPane.DEFAULT_OPTION, JOptionPane.ERROR_MESSAGE, null, options, "Ok");
			if (retorno == 1) {
				try {
					Runtime.getRuntime().exec("notepad logingFile.log");
				} catch (IOException e) {
					log.error("Error al grabar el producto", e);
				}
			}

			log.error("Error al grabar el producto", ex);
		}
	}

}
