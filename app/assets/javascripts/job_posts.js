function initialize_jquery_validator()
{

}

function initialize_ignore_date_time_handler()
{
  $('#ignore_date_time').change(function(event)
  {
    if ($(this).is(':checked') == true)
      $('#drive_date_date_picker').css('visibility', 'hidden');
    else
      $('#drive_date_date_picker').css('visibility', 'visible');
  });
}

function initialize_date_time_picker()
{
  $(document).ready(function()
  {
    $('#drive_date_date_picker').datetimepicker({
      format: 'DD/MM/YYYY HH:mm',
      minDate: moment(),
      ignoreReadonly: true
    });
  });
}

function preview_job_post()
{
  $('.preview').click(function(event)
  {
    company_name = $('#company_name').val();
    company_website = $('#company_website').val();
    job_type = $('#job_type').val();
    position = $('#position').val();
    loc = $('#location').val();
    compensation = $('#compensation').val();
    experience_in_months = $('#experience_in_months').val();
    bond_period_in_months = $('#bond_period_in_months').val();
    reporting_date_time = $('#reporting_date_time').val();
    eligibility_criteria = $('#eligibility_criteria').val();
    selection_process = $('#selection_process').val();
    job_description = $('#job_description').val();
    other_details = $('#other_details').val();
    console.log("company website :"+company_website);

    content = "";
    content += company_name;

    if (company_website != "")
      content += "(" + company_website + ")";

    content += " is hiring candidates for the position of " + position

    if (loc != "")
      content += " in these location(s) : [" + loc +"]. ";
    else
      content += ". ";

    if (job_type != "")
      content += "The nature of job is " + job_type + ". ";

    content += "The job requires " + experience_in_months + " months of experience. ";
    content += "There is " + bond_period_in_months + " months of bond period for the job. ";
    content += "Yearly compensation for the job is " + compensation + ". ";
    content += "The reporting date and time for the drive are " + reporting_date_time + "."

    $('#preview_div').remove();
    $('#create_update_job_post').append('<div class="transparent-panel" id="preview_div">' + content + '<div>')
    content_other = "More details : ";

    if(eligibility_criteria != "")
      $('#preview_div').append("<p class='more_details multiline_text'><b>Eligibility Criteria : </b>"
        + eligibility_criteria +"</p>");

    if(selection_process != "")
      $('#preview_div').append("<p class='more_details multiline_text'><b>Selection Process : </b>"
        + selection_process +"</p>");

    if(job_description != "")
      $('#preview_div').append("<p class='more_details multiline_text'><b>Job Description : </b>"
        + job_description +"</p>");

    if(other_details != "")
      $('#preview_div').append("<p class='more_details multiline_text'><b>Other Details : </b>"
        + other_details +"</p>")

    $('html, body').animate(
    {
      scrollTop: $("#preview_div").offset().top - 50  /* compensate header size */
    }, 1000);
  });
}
