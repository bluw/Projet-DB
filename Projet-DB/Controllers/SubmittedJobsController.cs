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
    public class SubmittedJobsController : ApiController
    {
        private MeditEntities db = new MeditEntities();

        public IEnumerable<ModelLibrary.SubmittedJob> getJobsProfessionTranslatedFromDatabase(string language)
        {
            var jobs = db.SubmittedJobs;
            List<ModelLibrary.SubmittedJob> list = new List<ModelLibrary.SubmittedJob>();
            foreach (var j in jobs) {
                var profession = findProfession(j.FK_Profession);
                var translatedEntity = findTranslation(profession.codeProf, language);
                var newJob = new ModelLibrary.SubmittedJob();
                fillJob(translatedEntity, j, newJob);

                list.Add(newJob);
            }

            return (list.ToArray());
        }

        private Profession findProfession(string fkProf)
        {
            return (from p
                    in db.Professions
                    where p.codeProf == fkProf
                    select p).Single();
        }

        private TranslationProfession findTranslation(string code, string language)
        {
            return (from t
                    in db.TranslationProfessions
                    where t.FK_Profession == code
                    && t.FK_Language == language
                    select t).Single();
        }

        private void fillJob(TranslationProfession profession, SubmittedJob job, ModelLibrary.SubmittedJob newJob)
        {
            newJob.IdJob = job.idJob;
            newJob.Profession = profession.translation;
            newJob.StartDate = job.startDate;
        }
    }
}