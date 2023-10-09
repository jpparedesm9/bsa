package com.cobiscorp.ecobis.frm.business.util;

import java.util.ArrayList;
import java.util.List;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.frm.business.dto.AnswerWithTable;
import com.cobiscorp.ecobis.frm.business.dto.ColumnAnswer;
import com.cobiscorp.ecobis.frm.business.dto.ColumnQuestion;
import com.cobiscorp.ecobis.frm.business.dto.Form;
import com.cobiscorp.ecobis.frm.business.dto.Item;
import com.cobiscorp.ecobis.frm.business.dto.Question;
import com.cobiscorp.ecobis.frm.business.dto.RowAnswer;
import com.cobiscorp.ecobis.frm.business.dto.Section;

import cobiscorp.ecobis.customerdatabusiness.dto.Answer;
import cobiscorp.ecobis.customerdatabusiness.dto.AnswerTable;
import cobiscorp.ecobis.customerdatabusiness.dto.FormData;
import cobiscorp.ecobis.customerdatabusiness.dto.FormQuestion;
import cobiscorp.ecobis.customerdatabusiness.dto.FormSection;
import cobiscorp.ecobis.customerdatabusiness.dto.QuestionCatalog;
import cobiscorp.ecobis.customerdatabusiness.dto.TableQuestion;

public class MappingData {
	private static final ILogger logger = LogFactory.getLogger(MappingData.class);

	public static Form toForm(FormData formData) {
		Form form = new Form();
		form.setIdForm(formData.getIdForm());
		form.setVersion(formData.getVersion());

		return form;
	}

	public static void mapSections(Form form, FormSection[] formSections) {
		if (form != null && formSections != null) {
			List<Section> sections = new ArrayList<Section>();
			if (logger.isDebugEnabled()) {
				logger.logDebug("Inicia mapeo de Secciones");
			}
			for (FormSection formSection : formSections) {
				Section section = new Section();
				section.setIdSection(formSection.getIdSection());
				section.setLabel(formSection.getLabel());
				section.setEnabled(formSection.getEnabled());
				sections.add(section);
			}
			form.setSection(sections);
		}
	}

	public static void mapQuestions(Form form, FormQuestion[] formQuestions, QuestionCatalog[] questionCatalogs,
			TableQuestion[] tableQuestions) {
		if (form != null && form.getSection() != null && formQuestions != null) {
			for (FormQuestion formQuestion : formQuestions) {
				Section section = getSection(form.getSection(), formQuestion.getIdSection());
				if (logger.isDebugEnabled()) {
					logger.logDebug("Mapea seccion: " + section);
				}
				if (section != null) {
					mapQuestion(section, formQuestion, questionCatalogs, tableQuestions);
				}
			}
		}

	}

	private static void mapQuestion(Section section, FormQuestion formQuestion, QuestionCatalog[] questionCatalogs,
			TableQuestion[] tableQuestions) {
		if (section != null && formQuestion != null) {
			if (section.getQuestions() == null) {
				section.setQuestions(new ArrayList<Question>());
			}
			Question question = new Question();
			question.setIdQuestion(formQuestion.getIdQuestion());
			question.setLabel(formQuestion.getLabel());
			question.setType(formQuestion.getAnswerType());
			question.setRequired(formQuestion.getRequired());
			question.setRows(formQuestion.getRows());
			question.setRepeated(formQuestion.getRepeated());
			if (formQuestion.getAnswerType().equals(Constants.TYPE_CATALOG)) {
				if (logger.isDebugEnabled()) {
					logger.logDebug("Mapea Pregunta tipo Catalogo ->" + formQuestion.getLabel());
				}
				mapCatalog(question, questionCatalogs);
			} else if (formQuestion.getAnswerType().equals(Constants.TYPE_TABLE)) {
				if (logger.isDebugEnabled()) {
					logger.logDebug("Mapea Pregunta tipo tabla ->" + formQuestion.getLabel());
				}
				mapTableQuestion(question, questionCatalogs, tableQuestions);
			}

			section.getQuestions().add(question);
		}
	}

	private static void mapCatalog(Question question, QuestionCatalog[] questionCatalogs) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Datos: " + questionCatalogs);
		}
		if (question != null && question.getType().equals(Constants.TYPE_CATALOG) && questionCatalogs != null
				&& questionCatalogs.length > 0) {
			List<Item> items = new ArrayList<Item>();
			for (QuestionCatalog questionCatalog : questionCatalogs) {
				if (questionCatalog.getIdPregunta().equals(question.getIdQuestion())) {
					Item item = new Item();
					item.setCode(questionCatalog.getCode());
					item.setValue(questionCatalog.getValue());
					items.add(item);
				}
			}
			question.setValues(items);
		}
	}

	private static Section getSection(List<Section> sections, Integer idSection) {
		if (sections != null && idSection != null) {
			for (Section section : sections) {
				if (section.getIdSection().equals(idSection)) {
					return section;
				}
			}
		}
		return null;
	}

	public static void mapTableQuestion(Question question, QuestionCatalog[] questionCatalogs,
			TableQuestion[] tableQuestions) {
		if (question != null && question.getType().equals(Constants.TYPE_TABLE) && questionCatalogs != null
				&& questionCatalogs.length > 0 && tableQuestions != null && tableQuestions.length > 0) {

			List<ColumnQuestion> columnQuestions = new ArrayList<ColumnQuestion>();
			int i = 1;
			if (logger.isDebugEnabled()) {
				logger.logDebug("Mapeo pregunta tabla: ");
			}
			for (TableQuestion tableQuestion : tableQuestions) {
				if (tableQuestion.getIdQuestion().equals(question.getIdQuestion())) {
					if (logger.isDebugEnabled()) {
						logger.logDebug("Mapeo columna: " + tableQuestion.getColumnName());
					}
					ColumnQuestion columnQuestion = new ColumnQuestion();
					columnQuestion.setIdColumn(i);
					columnQuestion.setLabel(tableQuestion.getColumnName());
					columnQuestion.setType(tableQuestion.getDataType());

					mapTableCatalog(questionCatalogs, tableQuestion, columnQuestion);
					i++;
					columnQuestions.add(columnQuestion);
				}
			}
			question.setTableQuestion(columnQuestions);

		}

	}

	private static void mapTableCatalog(QuestionCatalog[] questionCatalogs, TableQuestion tableQuestion,
			ColumnQuestion columnQuestion) {
		if (tableQuestion.getDataType().equals(Constants.TYPE_CATALOG)) {
			List<Item> items = new ArrayList<Item>();
			for (QuestionCatalog questionCatalog : questionCatalogs) {
				if (questionCatalog.getCatalog().equals(tableQuestion.getCatalog())) {
					Item item = new Item();
					item.setCode(questionCatalog.getCode());
					item.setValue(questionCatalog.getValue());
					items.add(item);
				}
			}
			columnQuestion.setValues(items);
		}
	}

	public static void mapAnwsersToQuestion(Answer[] answers, Question question) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia mapAnwsersToQuestion");
		}
		for (Answer answer : answers) {
			if (answer.getQuestionId().equals(question.getIdQuestion())) {
				question.setAnswer(answer.getAnswerDesc());
			}
		}
	}

	public static void mapTableAnswers(Form form, AnswerTable[] answersTable) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia mapTableAnswers");
		}
		List<AnswerWithTable> answerWithTableList = new ArrayList<AnswerWithTable>();
		Integer row = 1;

		for (Section section : form.getSection()) {
			for (Question question : section.getQuestions()) {

				if (Constants.TYPE_TABLE.equals(question.getType())) {
					AnswerWithTable answerWithTable = new AnswerWithTable();
					answerWithTable.setIdQuestion(question.getIdQuestion());
					int i = 0;
					RowAnswer rowAnswer = new RowAnswer();
					for (i = 0; i < answersTable.length; i++) {
						if (question.getIdQuestion().equals(answersTable[i].getQuestionId())) {
							row = answersTable[i].getRowId();
							if (logger.isDebugEnabled()) {
								logger.logDebug("Valores -> i:" + i + " row:" + row + " answersTable.length:"
										+ answersTable.length + " answersTable[i].getRowId():"
										+ answersTable[i].getRowId());
							}

							ColumnAnswer columnAnswer = new ColumnAnswer();
							columnAnswer.setAnwserType(answersTable[i].getAnwserType());
							columnAnswer.setAnswerDesc(answersTable[i].getAnswerDesc());
							columnAnswer.setColumn(answersTable[i].getColumnId());

							if (rowAnswer.getColumns() == null) {
								rowAnswer.setColumns(new ArrayList<ColumnAnswer>());
							}
							rowAnswer.getColumns().add(columnAnswer);

							if ((i + 1 < (answersTable.length - 1) && !answersTable[i + 1].getRowId().equals(row))
									|| (i + 1 >= answersTable.length)
									|| (!answersTable[i + 1].getQuestionId().equals(question.getIdQuestion()))) {
								if (answerWithTable.getRowList() == null) {
									answerWithTable.setRowList(new ArrayList<RowAnswer>());
								}
								answerWithTable.getRowList().add(rowAnswer);
								rowAnswer = new RowAnswer();
							}

							if ((i + 1 < (answersTable.length)
									&& !answersTable[i + 1].getQuestionId().equals(question.getIdQuestion()))
									|| (i + 1 >= answersTable.length)) {
								answerWithTableList.add(answerWithTable);
								answerWithTable = new AnswerWithTable();
								answerWithTable.setIdQuestion(question.getIdQuestion());
							}
						}
					}
				}
			}
		}
		form.setAnswerWithTable(answerWithTableList);
	}

}
