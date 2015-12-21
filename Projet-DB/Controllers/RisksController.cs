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
    public class RisksController : ApiController
    {
        private MeditEntities db = new MeditEntities();

        public IEnumerable<ModelLibrary.Risk> getRisksTranslatedFromDatabase(string language)
        {
            var risks = db.Risks;

            List<ModelLibrary.Risk> list = new List<ModelLibrary.Risk>();

            foreach (var r in risks) {
                var translatedEntity = findTranslation(r.codeRisk, language);
                var newRisk = new ModelLibrary.Risk();
                fillRisk(translatedEntity, newRisk);

                list.Add(newRisk);
            }

            return (list.ToArray());
        }

        private void fillRisk(TranslationRisk risk, ModelLibrary.Risk newRisk)
        {
            newRisk.CodeRisk = risk.FK_Risk;
            newRisk.Denomination = risk.translation;
        }

        private TranslationRisk findTranslation(string codeRisk, string language)
        {
            return (from t
                    in db.TranslationRisks
                    where t.FK_Risk == codeRisk
                    && t.FK_Language == language
                    select t).Single();
        }
    }
}