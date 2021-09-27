The objects in this extension are auto-managed and should never need
to be created, destroyed, or modified. All functionality should be
available in the scripts folder.

The only time you need to be careful with objects is if you are using
instance deactivation or things like instance_destroy(all). In these
cases you want to make sure not to touch the system's objects.