use 5.006;
use ExtUtils::MakeMaker;
WriteMakefile(
    'NAME'              => 'Text::Decorator',
    'VERSION_FROM'      => 'lib/Text/Decorator.pm',
    'PREREQ_PM'         => {
        URI::Find => 0, # Suggested
        Template  => 0, # Also suggested
        UNIVERSAL::require => 0
    },
);
