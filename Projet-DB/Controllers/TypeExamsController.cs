using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Description;
using Projet_DB.Models;

namespace Projet_DB.Controllers
{
    public class TypeExamsController : ApiController
    {
        private MeditEntities db = new MeditEntities();

        public IEnumerable<ModelLibrary.TypeExam> getRisksTranslatedFromDatabase(string language)
        {
            var exams = db.TypeExams;

            List<ModelLibrary.TypeExam> list = new List<ModelLibrary.TypeExam>();

            foreach (var e in exams) {
                var translatedEntity = findTranslation(e.codeExam, language);
                var newExam = new ModelLibrary.TypeExam();
                fillExam(translatedEntity, newExam);

                list.Add(newExam);
            }

            return (list.ToArray());
        }

        private void fillExam(TranslationExam exam, ModelLibrary.TypeExam newExam)
        {
            newExam.CodeExam = exam.FK_TypeExam;
            newExam.Denomination = exam.translation;
        }

        private TranslationExam findTranslation(string codeExam, string language)
        {
            return (from t
                    in db.TranslationExams
                    where t.FK_TypeExam == codeExam
                    && t.FK_Language == language
                    select t).Single();
        }
    }
}
 