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
    public class SubmissionsController : ApiController
    {
        private MeditEntities db = new MeditEntities();

        [ResponseType(typeof(Submission))]
        public IHttpActionResult PostSubmission(ModelLibrary.Submission newSubmission)
        {
            if (!ModelState.IsValid) {
                return BadRequest(ModelState);
            }

            if (LinkExists(newSubmission)) {
                return Conflict();
            }

            var submission = new Submission();
            fillSubmission(submission, newSubmission);

            db.Submissions.Add(submission);
            db.SaveChanges();

            return CreatedAtRoute("DefaultApi", new { id = submission.idSubmission }, submission);
        }

        private void fillSubmission(Submission submission, ModelLibrary.Submission newSubmission)
        {
            submission.FK_SubmittedJob = newSubmission.FkJob;
            submission.FK_TypeExam = newSubmission.FkExam;
        }

        private bool LinkExists(ModelLibrary.Submission sub)
        {
            return db.Submissions.Count(s => s.FK_TypeExam == sub.FkExam && s.FK_SubmittedJob == sub.FkJob) > 0;
        }
    }
}