use Test2::V0 -no_srand => 1;
use Test::DZil;

subtest 'basic' => sub {

  my $tzil = Builder->from_config(
    { dist_root => 'corpus/DZT' },
    {
      add_files => {
        'source/dist.ini' => simple_ini(
          {},
          # [GatherDir]
          'GatherDir',
          # [JavaScript::Minifier]
          [
            'JavaScript::Minifier' => {}
          ],
        )
      }
    }
  );

  $tzil->build;

  my @js_files = sort grep /\.js$/, map { $_->name } @{ $tzil->files };

  my @expected = qw( 
    public/js/all.js
    public/js/all.min.js
    public/js/comment.js
    public/js/comment.min.js
    public/js/screen.js
    public/js/screen.min.js
  );

  my $is_smaller = sub {
    my($orig_fn, $min_fn) = @_;
    #diag "read $orig_fn";
    my $orig = $tzil->slurp_file("source/$orig_fn");
    #diag "read $min_fn";
    my $min  = $tzil->slurp_file("build/$min_fn");
  
    cmp_ok length($orig), '>', length($min), 
      "$orig_fn [" . length($orig) . "] is larger than $min_fn [" . length($min) . "]";
  };

  is_filelist \@js_files, \@expected, 'minified all JavaScript files';
  $is_smaller->(qw( public/js/all.js     public/js/all.min.js ));
  $is_smaller->(qw( public/js/comment.js public/js/comment.min.js ));
  $is_smaller->(qw( public/js/screen.js  public/js/screen.min.js ));

};

subtest 'combine' => sub {

  my $tzil = Builder->from_config(
    { dist_root => 'corpus/DZT' },
    {
      add_files => {
        'source/dist.ini' => simple_ini(
          {},
          # [GatherDir]
          'GatherDir',
          # [JavaScript::Minifier]
          [
            'JavaScript::Minifier' => {
              output => 'public/js/awesome.min.js',
            }
          ],
        )
      }
    }
  );

  $tzil->build;

  my @js_files = sort grep /\.js$/, map { $_->name } @{ $tzil->files };

  my @expected = qw( 
    public/js/all.js
    public/js/awesome.min.js
    public/js/comment.js
    public/js/screen.js
  );

  is_filelist \@js_files, \@expected, 'minified to public/js/awesome.min.js';

  my $orig = join('', map { $tzil->slurp_file("source/public/js/$_.js") } qw( all comment screen ) );
  my $min  = $tzil->slurp_file("build/public/js/awesome.min.js");

  cmp_ok length($orig), '>', length($min), "original [" . length($orig) . "] is larger than min [" . length($min) ."]";

};

done_testing;
