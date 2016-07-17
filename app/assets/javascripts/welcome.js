function populate_team()
{
  names = ['Gagandeep Singh', 'Ekaspreet Singh', 'Ishmeet Singh', 'Ishaan Singh'];
  profilePhotos = ['http://i65.tinypic.com/ap8ykm.png', 'http://i65.tinypic.com/ap8ykm.png',
  'http://i65.tinypic.com/ap8ykm.png', 'http://i65.tinypic.com/ap8ykm.png'];
  workInfo = ['Software Developer at Josh Technology group', 'Software Developer at Nucleus',
  'Pursuing M.Eng from Queens University, CA', 'Software Engineer at HCL'];
  designation = ['Backend Dev', 'Frontend Dev', 'Visionary', 'Visionary'];
  content = ['Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod\
  tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,\
  quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo\
  consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse\
  cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non\
  proident, sunt in culpa qui officia deserunt mollit anim id est laborum.']

  $('.team_container').html('');
  for(i = 0; i < names.length; i++)
  {
    work_info_direction = ''
    designation_direction = ''
    if (i % 2 == 0)
    {
      work_info_direction = 'work_info_right'
      designation_direction = 'designation_right';
    }

    $('.team_container').append('<div class="team_member clearfix">\
      <div class="left_div">\
      <div class="display_pic"><img src="' + profilePhotos[i] + '"></div>\
      </div>\
      <div class="right_div">\
      <p class="work_info ' + work_info_direction + '">' + names[i] + " (" + workInfo[i] + ')</p>\
      <p class="designation ' + designation_direction + '">' + designation[i] + ' for GTBIT Alumni</p>\
      <p class="about">' + content[0] + '</p>\
      </div>\
      </div>');
  }
}
